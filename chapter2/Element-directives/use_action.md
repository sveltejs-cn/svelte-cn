### use:<font color=#9595a0>*action*</font>
```js
use:action
```
```js
use:action={parameters}
```
```js
action = (node: HTMLElement, parameters: any) => {
	update?: (parameters: any) => void,
	destroy?: () => void
}
```
`Actions` 是一个元素被创建时会调用的函数集。函数集中的函数会返回一个包含 `destroy` 的钩子函数的对象，`destroy` 会在元素被卸载的时候被调用。

```html
<script>
	function foo(node) {
		// the node has been mounted in the DOM

		return {
			destroy() {
				// the node has been removed from the DOM
			}
		};
	}
</script>

<div use:foo></div>
```

`Action` 可以有多个参数，如果返回对象有 `update` 方法，只要这些参数发生改变，这个方法会在 Svelte 更新标签之后被立即调用。
```html
<script>
	export let bar;

	function foo(node, bar) {
		// the node has been mounted in the DOM

		return {
			update(bar) {
				// the value of `bar` has changed
			},

			destroy() {
				// the node has been removed from the DOM
			}
		};
	}
</script>

<div use:foo={bar}></div>
```
> 不用担心如果我们为每个组件实例都重新声明了 `foo` 会有什么影响—— Svelte 会从组件的定义中移除不依赖于本地状态的函数。