### Actions

```
animate:name
```
```
animate:name={params}
```
```html
animation = (node: HTMLElement, { from: DOMRect, to: DOMRect } , params: any) => {
	delay?: number,
	duration?: number,
	easing?: (t: number) => number,
	css?: (t: number, u: number) => string,
	tick?: (t: number, u: number) => void
}
```
```html
DOMRect {
	bottom: number,
	height: number,
	​​left: number,
	right: number,
	​top: number,
	width: number,
	x: number,
	y:number
}
```
当一个通过 `each` 生成的块发生重排的时候，`Animation` 才会执行。当元素被删除的时候动画不会执行，只有 `each` 的列表数据发生重排的时候才会执行 `Animation` 。且`animate:` 指令只能在each块的直接子元素上。

```html
<!-- When `list` is reordered the animation will run-->
{#each list as item, index (item)}
	<li animate:flip>{item}</li>
{/each}
```
`animate` 可以是内置的 `animation` 方法或自定义的 `animation` 方法。

#### <p id="Animation参数">Animation参数</p>
和 `Actions` 还有 `transitions` 一样，`Animation` 也有参数。

```html
{#each list as item, index (item)}
	<li animate:flip="{{ delay: 500 }}">{item}</li>
{/each}
```
> 双大括号 `{{curlies}}` 不是特殊的语法，只是一个在表达式标签中包含一个对象字面量

#### <p id="自定义Animation函数">自定义Animation函数</p>


```html
<script>
	import { cubicOut } from 'svelte/easing';

	function whizz(node, { from, to }, params) {

		const dx = from.left - to.left;
		const dy = from.top - to.top;

		const d = Math.sqrt(dx * dx + dy * dy);

		return {
			delay: 0,
			duration: Math.sqrt(d) * 120,
			easing: cubicOut,
			css: (t, u) =>
				`transform: translate(${u * dx}px, ${u * dy}px) rotate(${t*360}deg);`
		};
	}
</script>

{#each list as item, index (item)}
	<div animate:whizz>{item}</div>
{/each}
```

`Animations` 可以是自定义的函数，函数的参数分别是 `node` 、`animation` 对象、及一个任何格式的参数。`animation` 对象参数包含 `from` 和 `to` 属性，且都包含了能描述元素的物理几何位置 `start` 和 `end` 的 `DOMRect` 属性。当列表数据发生重排，且 `DOM` 已经完成更新，`from` 属性表示的是元素在起始位置的 `DOMRect` ，`to` 属性表示的是元素结束位置的 `DOMRect` 。

如果返回的对象有 `css` 的方法，`Svelte` 会为这个元素创建并执行一个 `css` 的动画。

当缓动动画执行的时候，`t` 从 `0` 变化到 `1`，且会被作为参数传入到css方法中，参数 `u` 等同于 `1-t`。

在动画开始之前，`animate` 会被通过不同的参数 `t` 和 `u` 反复的调用。

自定义的 `animation` 函数同样可以返回 `tick` 函数，在动画的执行过程中被调用，同样的也是以参数 `t` 和 `u`。

```html
<script>
	import { cubicOut } from 'svelte/easing';

	function whizz(node, { from, to }, params) {

		const dx = from.left - to.left;
		const dy = from.top - to.top;

		const d = Math.sqrt(dx * dx + dy * dy);

		return {
		delay: 0,
		duration: Math.sqrt(d) * 120,
		easing: cubicOut,
		tick: (t, u) =>
			Object.assign(node.style, {
				color: t > 0.5 ? 'Pink' : 'Blue'
			});
	};
	}
</script>

{#each list as item, index (item)}
	<div animate:whizz>{item}</div>
{/each}
```
> 尽可能的使用 `css` 而不是 `tick` 函数，之所以这样做-是因为 `css` 动画可以在主线程上进行，防止在低端设备出现卡顿。
