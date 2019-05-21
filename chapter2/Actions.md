### Actions
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
Actions是一个元素被创建的时候会被调用的函数集，且会返回一个包含`destory`的钩子函数的对象，该方法会在元素被卸载的时候被调用。
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

Action可以有多个参数，如果返回值有`update`方法，每当这些参数改变的时候，在Svelte已经更新标记之后会被立即被调用。
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
> 不用担心如果我们为每个组件实例都重新声明`foo`的Action会有什么影响-Svelte会从组件的定义中移除不依赖于本地状态的函数。