import hashlib
import json
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import export


class MediaTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.out = self.root / "out"
        self.source = self.root / "source.png"
        self.source.write_bytes(b"image bytes")
        self.digest = hashlib.sha256(self.source.read_bytes()).hexdigest()

    def test_copies_and_records_hash(self):
        media = export.Media(self.out)
        line = media.add("paintings/a", self.source, "final.png", "Final", self.digest)
        self.assertEqual((self.out / "paintings/a/final.png").read_bytes(), self.source.read_bytes())
        self.assertEqual(line, "- [final.png](final.png): Final; SHA-256 `%s`" % self.digest)

    def test_identical_files_share_one_copy_across_exports(self):
        media = export.Media(self.out)
        media.add("paintings/a", self.source, "final.png", "Final")
        media = export.Media(self.out)
        line = media.add("paintings/b", self.source, "final.png", "Final")
        self.assertIn("(../a/final.png)", line)
        self.assertEqual(len(list(self.out.rglob("*.png"))), 1)

    def test_mismatched_hash_is_rejected_before_copy(self):
        with self.assertRaisesRegex(ValueError, "checksum mismatch"):
            export.Media(self.out).add("paintings/a", self.source, "final.png", "Final", "0" * 64)
        self.assertFalse(self.out.exists())

    def test_oversized_media_is_rejected_before_copy(self):
        with patch.object(export, "MAX_MEDIA_BYTES", 1):
            with self.assertRaisesRegex(ValueError, "exceeds 50 MiB"):
                export.Media(self.out).add("paintings/a", self.source, "final.png", "Final")
        self.assertFalse(self.out.exists())

    def test_conflicting_name_is_not_overwritten(self):
        media = export.Media(self.out)
        media.add("paintings/a", self.source, "final.png", "Final")
        self.source.write_bytes(b"new image")
        with self.assertRaisesRegex(ValueError, "different content"):
            media.add("paintings/a", self.source, "final.png", "Final")
        self.assertEqual(export.sha256(self.out / "paintings/a/final.png"), self.digest)

    def test_operator_labels_are_normalized_only_in_operator_records(self):
        self.assertEqual(export.scrub_text("The Captain confirmed", "runs/wc1/LAUNCH.md"), "The operator confirmed")
        self.assertEqual(export.scrub_text("the Captain's go", "runs/wc2/handoff/prompts/index.md"), "the operator's go")
        self.assertEqual(export.scrub_text("addressed Captain notification", "runs/wc2/LAUNCH.md"),
                         "addressed notification to the operator")
        self.assertEqual(export.scrub_text("Capy MCP", "runs/try1/session.jsonl"), "MCP")
        self.assertEqual(export.scrub_text("The Captain", "paintings/a/journal.md"), "The Captain")

    def test_one_painting_export_includes_media_and_hashes(self):
        site = self.root / "site"
        data = self.root / "data"
        studio_data = site / "dist/studio/data"
        studio_data.mkdir(parents=True)
        (studio_data / "sessions.json").write_text("[]")
        (site / "dist/paintings.json").write_text(json.dumps([{"id": "a", "studio": "early-painter"}]))
        (site / "inputs_data/docs").mkdir(parents=True)
        (site / "inputs_data/given.json").write_text("{}")
        (data / "finals").mkdir(parents=True)
        (data / "clips").mkdir()
        (data / "finals/a.png").write_bytes(self.source.read_bytes())
        (data / "clips/a.mp4").write_bytes(b"clip bytes")
        (data / "manifest.json").write_text(json.dumps([{
            "id": "a", "round": 1, "painter_model": "test", "final_file": "finals/a.png", "clip": "a.mp4"
        }]))
        names = self.root / "private-names.json"
        names.write_text(json.dumps({k: ["test-private-name"] for k in ("accounts", "hosts", "url_hosts", "tokens")}))
        previous_clip = self.out / "paintings/a/timelapse-social.mp4"
        previous_clip.parent.mkdir(parents=True)
        previous_clip.write_bytes(b"archived clip")
        previous_line = "- [timelapse-social.mp4](timelapse-social.mp4): Archived social clip; SHA-256 `%s`" % export.sha256(previous_clip)
        previous_clip.with_name("RECORD.md").write_text("# Painting\n\n## Media\n\n" + previous_line + "\n")
        args = ["export.py", str(self.out), "--runs-data", str(self.root / "runs-data"),
                "--private-names", str(names), "--only", "a"]
        with patch.object(export, "SITE", site), patch.object(export, "DATA", data), \
                patch.object(export, "STUDIO_DATA", studio_data), patch.object(sys, "argv", args):
            export.main()
            export.main()
        self.addCleanup(export.SUBS.clear)
        record = (self.out / "paintings/a/RECORD.md").read_text()
        self.assertEqual(record.count(previous_line), 1)
        for name in ("final.png", "timelapse.mp4"):
            media = self.out / "paintings/a" / name
            self.assertTrue(media.is_file())
            self.assertIn("[%s](%s)" % (name, name), record)
            self.assertIn(export.sha256(media), record)


if __name__ == "__main__":
    unittest.main()
