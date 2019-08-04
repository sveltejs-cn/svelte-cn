### svelte/motion

`svelte/motion` 模块导出两个方法，`tweened` 和 `spring`。用于创建可写的 stores，其值是在设置和更新之后随着时间变化，而不是立即变化。

#### <p id="tweened">tweened</p>

```js
store = tweened(value: any, options)
```

`Tweened` 生成的 store 的值是在固定的几个时机去更新。以下是可选的选项：

- delay (number, 默认 `0`) - 开始之前的毫秒数
- duration (number, 默认 `400`) - 动画持续的毫秒数
- easing (function, 默认 `t => t`) - 一个 `easing` 函数
- interpolate（function）- 见下文

`store.set` 和 `store.update` 可以接收第二个选项参数，这个参数将覆盖实例化时传入的选项。

这两个函数都返回一个`Promise`，且是在 `tween` 完成的时候 `resolve` 。 如果 `tween` 被终端，那么promise 将永远都不会 resolve。

开箱即用，Svelte将在两个数字，两个数组或两个对象之间进行插值（只要数组和对象是相同的'结构'，它们的'子元素'属性也是数字）。

```js
<script>
	import { tweened } from 'svelte/motion';
	import { cubicOut } from 'svelte/easing';

	const size = tweened(1, {
		duration: 300,
		easing: cubicOut
	});

	function handleClick() {
		// this is equivalent to size.update(n => n + 1)
		$size += 1;
	}
</script>

<button
	on:click={handleClick}
	style="transform: scale({$size}); transform-origin: 0 0"
>embiggen</button>
```

`interpolate` 允许你在任意值之间进行补间。它必须是 `（a，b）=> t => value` 形式的函数。其中 `a`  是个起始值，`b` 是目标值， `t` 是 0 到 1 之间的数值，`value` 是结果。例如，我们可以使用 `d3-interpolate` 包在两种颜色之间平滑的插值。

```js
<script>
	import { interpolateLab } from 'd3-interpolate';
	import { tweened } from 'svelte/motion';

	const colors = [
		'rgb(255, 62, 0)',
		'rgb(64, 179, 255)',
		'rgb(103, 103, 120)'
	];

	const color = tweened(colors[0], {
		duration: 800,
		interpolate: interpolateLab
	});
</script>

{#each colors as c}
	<button
		style="background-color: {c}; color: white; border: none;"
		on:click="{e => color.set(c)}"
	>{c}</button>
{/each}

<h1 style="color: {$color}">{$color}</h1>
```

#### <p id="spring">spring</p>

```js
store = spring(value: any, options)
```

一个 `spring` 的 store根据它的 `stiffness` 和 `damping` 参数逐渐变成其目标值。虽然 `tweened` 生成的 store 是在固定的时间内变化值，而`spring` 生成的stores 值改变的时间，是由现有的速度决定的，这样就允许更多自然可见的状态下的运动。可以使用以下选项：

stiffness (number, default 0.15) — a value between 0 and 1 where higher means a 'tighter' spring
damping (number, default 0.8) — a value between 0 and 1 where lower means a 'springier' spring
precision (number, default 0.001) — determines the threshold at which the spring is considered to have 'settled', where lower means more precise

- `stiffness`(number, 默认 `0.15`) - 从 0 到 1 的值，值越大表示是 spring 更‘紧’
- `damping`(number, 默认 `0.8`) - 从 0 到 1 的值，值越小表示是 spring 的弹性越大
- `precision`(number, 默认 `0.001`) - 决定了 spring 的值稳定的一个阈值，值越小表示越精确

与 `tweened` 生成的 store 一样，`set` 和 `update` 返回的是 `Promise`，如果spring 运动结束，就会 resolve。`store.stiffness` 和 `store.damping` 可以在 spring 的运动过程中进行修改，且会立即生效。

`set` 和 `update` 都可以使用第二个参数 - 一个有 `hard` 和 `soft` 属性的对象。`{hard: true}`立即设置目标值；`{ soft: n}` 在设置值之前保留 `n` 秒现有的动力。 `{ soft: true}` 相当与 `{soft: 0.5}` 。

```js
<script>
	import { spring } from 'svelte/motion';

	const coords = spring({ x: 50, y: 50 }, {
		stiffness: 0.1,
		damping: 0.25
	});
</script>
```