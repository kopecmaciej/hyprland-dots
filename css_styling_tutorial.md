# CSS Styling Tutorial for Window Bar and Components

This CSS code is designed to style a window bar (likely for a window manager like i3 or sway) and its components. Let's break it down bit by bit:

## General Styling

```css
* {
  font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", Roboto, Helvetica, Arial, sans-serif;
  font-size: 14px;
  min-height: 0;
  transition: all 0.3s ease;
}
```

- **`*`**: Applies to all elements.
- **`font-family`**: Sets the font family to a combination of "JetBrainsMono Nerd Font", "Font Awesome 6 Free", Roboto, Helvetica, Arial, and sans-serif.
- **`font-size`**: Sets the font size to 14px.
- **`min-height`**: Sets the minimum height to 0.
- **`transition`**: Applies a smooth transition effect to all properties over 0.3 seconds.

## Window Bar Styling

```css
window#waybar {
  background: transparent;
  border: 0px solid rgba(100, 100, 100, 0.2);
  color: #8b8d94;
  animation: gradient_f 20s ease-in infinite;
  margin-right: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.5);
}
```

- **`window#waybar`**: Targets the window with the ID `waybar`.
- **`background`**: Sets the background to transparent.
- **`border`**: Sets a border with 0px width and a light gray color.
- **`color`**: Sets the text color to a light gray.
- **`animation`**: Applies a gradient animation named `gradient_f` that lasts 20 seconds, easing in, and repeats infinitely.
- **`margin-right`**: Adds a right margin of 20px.
- **`box-shadow`**: Adds a shadow effect to the window.

## Gradient Animation

```css
@keyframes gradient_f {
  0% {
    background-position: 0% 200%;
  }
  50% {
    background-position: 200% 0%;
  }
  100% {
    background-position: 400% 200%;
  }
}
```

- **`@keyframes gradient_f`**: Defines a keyframe animation named `gradient_f`.
- **`0%`**: At the start, the background position is set to 0% on the x-axis and 200% on the y-axis.
- **`50%`**: At the halfway point, the background position is set to 200% on the x-axis and 0% on the y-axis.
- **`100%`**: At the end, the background position is set to 400% on the x-axis and 200% on the y-axis.

## Hidden Window Bar

```css
window#waybar.hidden {
  opacity: 0.2;
}
```

- **`window#waybar.hidden`**: Targets the window with the ID `waybar` when it has the class `hidden`.
- **`opacity`**: Sets the opacity to 0.2, making it semi-transparent.

## Window Component Styling

```css
#window {
  background: transparent;
}
```

- **`#window`**: Targets the element with the ID `window`.
- **`background`**: Sets the background to transparent.

## Workspaces Styling

```css
#workspaces {
  margin: 2px 1px 0px;
  padding: 0 5px;
  background: #1a1b26;
  border-radius: 10px;
  border: 0px solid rgba(100, 100, 100, 0.2);
}
```

- **`#workspaces`**: Targets the element with the ID `workspaces`.
- **`margin`**: Sets the margin to 2px top, 1px right, and 0px bottom.
- **`padding`**: Sets the padding to 0px top and bottom, 5px left and right.
- **`background`**: Sets the background color to a dark gray.
- **`border-radius`**: Sets the border radius to 10px.
- **`border`**: Sets a border with 0px width and a light gray color.

## Workspaces Button Styling

```css
#workspaces button {
  color: #8b8d94;
  border-radius: 4px;
}
```

- **`#workspaces button`**: Targets buttons inside the `workspaces` element.
- **`color`**: Sets the text color to a light gray.
- **`border-radius`**: Sets the border radius to 4px.

## Active Workspace Button Styling

```css
#workspaces button.active {
  color: #c0c0c0;
  background-color: #2f3144;
  box-shadow: inset 0 -3px #bf4040;
}
```

- **`#workspaces button.active`**: Targets active buttons inside the `workspaces` element.
- **`color`**: Sets the text color to a lighter gray.
- **`background-color`**: Sets the background color to a darker gray.
- **`box-shadow`**: Adds an inset shadow effect.

## Hover Effect on Workspaces Button

```css
#workspaces button:hover {
  background: #2a2b3c;
  color: #d4d4d4;
  box-shadow: inset 0 -3px #ff6666;
}
```

- **`#workspaces button:hover`**: Targets buttons inside the `workspaces` element when hovered.
- **`background`**: Sets the background color to a darker gray.
- **`color`**: Sets the text color to a light gray.
- **`box-shadow`**: Adds an inset shadow effect.

## Custom and System Components Styling

```css
#custom-gpu_mem,
#custom-gpu_temp,
#clock,
#battery,
#cpu,
#memory,
#network,
#pulseaudio,
#tray {
  padding: 0 12px;
  margin: 3px 2px 0px;
  color: #d4d4d4;
  background-color: #1a1b26;
  border: 1px solid rgba(100, 100, 100, 0.2);
  border-radius: 8px;
  transition: all 0.3s ease;
  background-color: #2f3144;
}
```

- **`#custom-gpu_mem, #custom-gpu_temp, #clock, #battery, #cpu, #memory, #network, #pulseaudio, #tray`**: Targets specific elements.
- **`padding`**: Sets the padding to 0px top and bottom, 12px left and right.
- **`margin`**: Sets the margin to 3px top, 2px right, and 0px bottom.
- **`color`**: Sets the text color to a light gray.
- **`background-color`**: Sets the background color to a dark gray.
- **`border`**: Sets a border with 1px width and a light gray color.
- **`border-radius`**: Sets the border radius to 8px.
- **`transition`**: Applies a smooth transition effect to all properties over 0.3 seconds.

## Battery Styling

```css
#battery {
  background-color: #262833;
}
```

- **`#battery`**: Targets the element with the ID `battery`.
- **`background-color`**: Sets the background color to a darker gray.

## Charging and Plugged Battery Styling

```css
#battery.charging,
#battery.plugged {
  background-color: #a6e3a1;
}
```

- **`#battery.charging, #battery.plugged`**: Targets the battery element when it is charging or plugged in.
- **`background-color`**: Sets the background color to a greenish color.

## Battery Critical State Styling

```css
@keyframes blink {
  to {
    background-color: #f38ba8;
    color: #11111b;
  }
  from {
    background-color: #11111b;
    color: #f38ba8;
  }
}

#battery.critical:not(.charging) {
  background-color: #8b0000;
  color: #ffffff;
  text-shadow: 0 0 5px #ff0000;
  animation: blink 1s linear infinite alternate;
}
```

- **`@keyframes blink`**: Defines a keyframe animation named `blink`.
- **`to`**: At the end of the animation, the background color is set to a pinkish color and the text color to a dark gray.
- **`from`**: At the start of the animation, the background color is set to a dark gray and the text color to a pinkish color.
- **`#battery.critical:not(.charging)`**: Targets the battery element when it is in a critical state and not charging.
- **`background-color`**: Sets the background color to a dark red.
- **`color`**: Sets the text color to white.
- **`text-shadow`**: Adds a red shadow to the text.
- **`animation`**: Applies the `blink` animation that lasts 1 second, linear timing, repeats infinitely, and alternates.

## Network Disconnected Styling

```css
#network.disconnected {
  background-color: #f38ba8;
  animation: blink 0.5s linear infinite alternate;
}
```

- **`#network.disconnected`**: Targets the network element when it is disconnected.
- **`background-color`**: Sets the background color to a pinkish color.
- **`animation`**: Applies the `blink` animation that lasts 0.5 seconds, linear timing, repeats infinitely, and alternates.

## Muted PulseAudio Styling

```css
#pulseaudio.muted {
  background-color: #f38ba8;
}
```

- **`#pulseaudio.muted`**: Targets the PulseAudio element when it is muted.
- **`background-color`**: Sets the background color to a pinkish color.

## Clock Styling

```css
#clock {
  margin-right: 15px;
}
```

- **`#clock`**: Targets the element with the ID `clock`.
- **`margin-right`**: Adds a right margin of 15px.

## Hover Effects on Components

```css
#clock:hover,
#battery:hover,
#cpu:hover,
#memory:hover,
#network:hover,
#pulseaudio:hover,
#tray:hover {
  border-radius: 12px;
  box-shadow: 0 0 8px rgba(255, 0, 0, 0.2);
  background-color: #2f3144;
}
```

- **`#clock:hover, #battery:hover, #cpu:hover, #memory:hover, #network:hover, #pulseaudio:hover, #tray:hover`**: Targets specific elements when hovered.
- **`border-radius`**: Sets the border radius to 12px.
- **`box-shadow`**: Adds a shadow effect.
- **`background-color`**: Sets the background color to a darker gray.

This CSS code provides a comprehensive styling for a window bar and its components, including animations, hover effects, and specific state-based styles.
