# The painter's last reply

You have a very sharp eye—and you're right. Looking critically at the crown, there are three specific reasons the branches came out looking peculiar rather than genuinely oak-like:

1. **Over-literal caliper symmetry in the primary boughs**:
   In translating Friedrich's principle of "an arch, a curve that opens upward" and "gnarled branches inside a symmetric frame" into `body_of` coordinates, I bowed the two main boughs outward (`x = 362` and `x = 638`) and then curved them smoothly back inward toward the moon (`x = 404` and `x = 592`). Because their widths and curves mirror each other so closely, they read almost like a pair of calipers or antlers rather than an ancient oak whose overarching symmetry emerges roughly from asymmetric limbs.

2. **`b:gesture` splines vs. crooked oak elbows**:
   In [trees.md](file://[local path redacted] pedunculate oak (*Quercus robur*) is described as having crooked, zigzagging sympodial branching because terminal buds cluster and die back, forcing side shoots to take over at sharp angles. However, I drew the third- and fourth-order branches as single continuous `b:gesture` paths through 4–5 points. Because `b:gesture` interpolates a smooth spline through its points, what were meant to be abrupt, angular oak turns came out as smooth, whip-like S-curves. To get true oak elbows, each segment between forks needs to be a separate short stroke or a polyline broken at corners (`"c"` in `outline`).

3. **The `bud_cluster` mistake and the `extend_vtip` trident pattern**:
   - In **Campaign 3b**, I tried to paint oak's clustered terminal buds by writing a helper (`draw_shoot`) that added two tiny diverging strokes at the tip of every branch with pressure rising to `0.32` at the very end. That produced a repeated two-pronged "lobster-claw" V-tip at the end of every shoot.
   - In **Campaign 4b**, to disguise those clubbed V-tips without scraping the dry sky, I wrote `extend_vtip` to grow two diverging shoots plus one side twig out of each V-tip. While that fixed the blunt ends, calling the same geometric helper across all 60+ tips turned every branch end into a nearly identical three-pronged fan or broom-tip at the outer perimeter of the boughs, leaving the interior of the limbs relatively bare and concentrating all the fine branching into uniform tufts at the tips.
