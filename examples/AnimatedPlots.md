# Example: Animated Plots

Here's an example of animated plots that you get when you plot stuff in a loop in a Live Script.

```matlab:Code
ax = axes;
axis(ax, [0, 2*pi, -1, 1])
hold(ax, "on")

for i = linspace(0, 2*pi)
    scatter(ax, i, cos(i), 'b')
    drawnow limitrate
end
```

![figure_0.png](AnimatedPlots_images/figure_0.png)

We'll try to figure out how to export those as animated GIFs or video files or something.

When you run the Live Script, it only does one pass through the sequence. How should we handle that?

<!-- This Markdown was generated from Matlab Live Script with Janklab ExportMlx (https://exportmlx.janklab.net) -->
