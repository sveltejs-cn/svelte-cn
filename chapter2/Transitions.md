### Transitions
```
transition:name
```
```
transition:name={params}
```
```
transition:name|local
```
```
transition:name|local={params}
```
```
in:name
```
```
in:name={params}
```
```
in:name|local
```
```
in:name|local={params}
```
```
out:name
```
```
out:name={params}
```
```
out:name|local
```
```
out:name|local={params}
```
```js
transition = (node: HTMLElement, params: any) => {
	delay?: number,
	duration?: number,
	easing?: (t: number) => number,
	css?: (t: number, u: number) => string,
	tick?: (t: number, u: number) => void
}
```
`transition` 是在元素的状态变更的时候触发的，如元素的进入和离开。过渡函数在组件首次挂载的时候不会执行，后续的一连串的更新才会执行。

在正在离开的块中的元素会一直在 DOM 中，直到所有的过渡动画执行完成。
```html
{#if visible}
	<div transition:fade>
		fades in and out
	</div>
{/if}
```
`transition: ` 表明是一个双向的过渡，意思是在变化的执行过程中平滑的来回切换执行方向。

`in: ` 和 `out:` 指令不是双向的。进入的过渡执行的过程中，切换至离开动画，进入动画会继续执行，且与离开动画并存。如果之前离开的动画还未执行完成，会重新开启离开的动画。

```html
{#if visible}
	<div in:fly out:fade>
		flies in, fades out
	</div>
{/if}
```
> 默认情况下，过渡动画在首次渲染的时候不会执行，你可以在[创建组件](https://svelte.dev/docs#Client-side_component_API)的时候，通过定义 `intro: true` 来修改默认行为。

#### <p id="Transition参数">Transition参数</p>

和 `Actions` 一样，`transition` 也可自定义参数。
```html
{#if visible}
	<div transition:fade="{{ duration: 2000 }}">
		flies in, fades out over two seconds
	</div>
{/if}
```

> `{{curlies}}` 这种双大括号并不是什么特殊的语法，只是一个在表达式标签中包含一个对象字面量。

#### <p id="自定义过渡函数">自定义transition函数</p>

`Transitions` 支持自定义过渡函数，如果返回的对象有 css 的函数，Svelte 会在这个元素上创建并播放 `css` 动画。

```html
<script>
	import { elasticOut } from 'svelte/easing';

	export let visible;

	function whoosh(node, params) {
		const existingTransform = getComputedStyle(node).transform.replace('none', '');

		return {
			delay: params.delay || 0,
			duration: params.duration || 400,
			easing: params.easing || elasticOut,
			css: (t, u) => `transform: ${existingTransform} scale(${t})`
		};
	}
</script>

{#if visible}
	<div in:whoosh>
		whooshes in
	</div>
{/if}
```
在 `easing` 函数执行完成之后，会传入 `css` 函数 `1` 或 `0` 的参数 `t` 。在进入动画中，是从 `0` 变化到 `1` ，在离开动画中，是从 `1` 变化到 `0` -换句话说，`1` 表示元素的初始状态，就好像没有发生过变化。参数 `u` 等同于 `1-t`。

在过渡开始之前，函数被不同的参数 `t` 和 `u` 反复调用。

自定义的过渡函数，也可以返回一个tick函数，该函数在过渡变化的过程中同样会以参数 `t` 和 `u` 被调用。

```html
<script>
	export let visible = false;

	function typewriter(node, { speed = 50 }) {
		const valid = (
			node.childNodes.length === 1 &&
			node.childNodes[0].nodeType === 3
		);

		if (!valid) return {};

		const text = node.textContent;
		const duration = text.length * speed;

		return {
			duration,
			tick: (t, u) => {
				const i = ~~(text.length * t);
				node.textContent = text.slice(0, i);
			}
		};
	}
</script>

{#if visible}
	<p in:typewriter="{{ speed: 20 }}">
		The quick brown fox jumps over the lazy dog
	</p>
{/if}
```
> 尽可能的使用 css 而不是 `tick` 函数-因为css的动画就会在主线程上运行，这样可以防止在性能差的设备上卡顿。

`transition` 如果返回了一个函数，而不是 `transition` 对象，那么这个函数会在下一个微任务被调用。这样就支持多个 `transition` 同时进行，这也是为什么可以实现交叉淡入的效果。

#### <p id="Transition事件">Transition事件</p>

一个定义了 `transition` 的元素，除了会调用标准的 `DOM` 事件，还会调用以下这些事件：
- `introstart`
- `introend`
- `outrostart`
- `outroend`

```html
{#if visible}
	<p
		transition:fly="{{ y: 200, duration: 2000 }}"
		on:introstart="{() => status = 'intro started'}"
		on:outrostart="{() => status = 'outro started'}"
		on:introend="{() => status = 'intro ended'}"
		on:outroend="{() => status = 'outro ended'}"
	>
		Flies in and out
	</p>
{/if}
```

`local transition` 只会在其所属块的创建或销毁的时候播放，而不是在其父级块的创建或销毁的时候。

```html
{#if x}
	{#if y}
		<p transition:fade>
			fades in and out when x or y change
		</p>

		<p transition:fade|local>
			fades in and out only when y changes
		</p>
	{/if}
{/if}
```