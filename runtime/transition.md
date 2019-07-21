## svelte/transition

`svelte/transition` 模块暴露了 6 个方法，分别是：`fade`，`fly`，`slide`，`scale`，`draw` 和 `crossfade`。它们是用于 svelte `transitions`。

### fade
```
transition:fade={params}
```
```
in:fade={params}
```
```
out:fade={params}
```


```html
<script>
	import { fade } from 'svelte/transition';
</script>

{#if condition}
	<div transition:fade="{{delay: 250, duration: 300}}">
		fades in and out
	</div>
{/if}
```
`in` 过渡动画是透明度从 0 过渡到当前指定的透明度，`out` 过渡动画是透明度从当前指定的透明度过渡到 0。
`fade` 可以传入以下几个参数：
- `dealy`（`number`，默认为 0）——动画开始之前的延迟毫秒数。
- `duration`（`number`，默认为 400）——过渡动画持续的毫秒数。
你可以在 [transition tutorial](https://svelte.dev/tutorial/transition) 中看到 `fade` 过渡动画是如何被使用的。

### fly
```
transition:fly={params}
```
```
in:fly={params}
```
```
out:fly={params}
```
设定元素在 x 轴、y 轴以及透明度上的动画。`in` 过渡动画将会从元素当前（默认）的状态过渡到用户提供的从参数传入的状态。`out` 过渡动画将会从用户提供的状态过渡到默认的状态。
```html
<script>
	import { fly } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';
</script>

{#if condition}
	<div transition:fly="{{delay: 250, duration: 300, x: 100, y: 500, opacity: 0.5, easing: quintOut}}">
		flies in and out
	</div>
{/if}
```
`fly` 可以传入以下几个参数：
- `dealy`（`number`，默认为 0）——动画开始之前的延迟毫秒数。
- `duration`（`number`，默认为 400）——过渡动画持续的毫秒数。
- `easing`（`function`，默认为 `cubicOut`）——一个 [easing function](https://svelte.dev/docs#svelte_easing)
- `x`（`number`，默认为 0)—— x 轴上的偏移量，即渐入时的开始量，渐出时的结束量。
- `y`（`number`，默认为 0)—— y 轴上的偏移量，即渐入时的开始量，渐出时的结束量。
- `opacity`（`number，默认为 0）—— 动画时的透明度值，即渐入时的开始量，渐出时的结束量。
你可以在 [transition tutorial](https://svelte.dev/tutorial/transition) 中看到 `fade` 过渡动画是如何被使用的。

### slide
```
transition:slide={params}
```
```
in:slide={params}
```
```
out:slide={params}
```
渐入或渐出时滑动元素。
```html
<script>
	import { slide } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';
</script>

{#if condition}
	<div transition:slide="{{delay: 250, duration: 300, easing: quintOut }}">
		slides in and out
	</div>
{/if}
```
`slide` 可以传入以下几个参数：
- `dealy`（`number`，默认为 0）——动画开始之前的延迟毫秒数。
- `duration`（`number`，默认为 400）——过渡动画持续的毫秒数。
- `easing`（`function`，默认为 `cubicOut`）——一个 [easing function](https://svelte.dev/docs#svelte_easing)

### scale
```
transition:scale={params}
```
```
in:scale={params}
```
```
out:scale={params}
```

```html
<script>
	import { scale } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';
</script>

{#if condition}
	<div transition:scale="{{duration: 500, delay: 500, opacity: 0.5, start: 0.5, easing: quintOut}}">
		scales in and out
	</div>
{/if}
```

`scale` 可以传入以下几个参数：
- `dealy`（`number`，默认为 0）——动画开始之前的延迟毫秒数。
- `duration`（`number`，默认为 400）——过渡动画持续的毫秒数。
- `easing`（`function`，默认为 `cubicOut`）——一个 [easing function](https://svelte.dev/docs#svelte_easing)
- `start`（`number`，默认为 0）——动画时的缩放值，即渐入时的开始量，渐出时的结束量。
- `opacity`（`number，默认为 0）—— 动画时的透明度值，即渐入时的开始量，渐出时的结束量。

### draw
```
transition:draw={params}
```
```
in:draw={params}
```
```
out:draw={params}
```

```html
<script>
	import { draw } from 'svelte/transition';
	import { quintOut } from 'svelte/easing';
</script>

<svg viewBox="0 0 5 5" xmlns="http://www.w3.org/2000/svg">
	{#if condition}
		<path transition:draw="{{duration: 5000, delay: 500, easing: quintOut}}"
					d="M2 1 h1 v1 h1 v1 h-1 v1 h-1 v-1 h-1 v-1 h1 z"
					fill="none"
					stroke="cornflowerblue"
					stroke-width="0.1px"
					stroke-linejoin="round"
		/>
	{/if}
</svg>
```
SVG 元素笔画的动画，就像管道中的蛇一样。在过渡动画的开始路径并不可见，随着时间的推移逐渐绘制这个路径。`out` 过渡动画时从路径可见的状态开始，逐渐隐藏路径。`draw` 仅适用于具有 `getTotalLength` 方法的元素，如 `<path>` 和` <polyline>`

`scale` 可以传入以下几个参数：
- `dealy`（`number`，默认为 0）——动画开始之前的延迟毫秒数。
- `speed`（`number`，默认为 undefined）——动画的速度，详见下面的说明。
- `duration`（`number`，默认为 800）——过渡动画持续的毫秒数。
- `easing`（`function`，默认为 `cubicOut`）——一个 [easing function](https://svelte.dev/docs#svelte_easing)

`speed` 参数是用来设置与路径长度相关的转换动画持续时间的一种方法。它是一个用在路径长度上的修饰符：`duration = length / speed`。一个长度为 1000 像素的路径，速度为 1 时，它的持续时间是 `1000ms`，当速度设置为 `0.5` 时会让持续时间折半，当设置为 `2` 时持续时间会翻倍。