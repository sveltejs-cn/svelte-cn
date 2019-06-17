### style

`<style>`块中的CSS将只作用于该组件,成为私有样式，与外部隔离。
这通过向受影响的元素添加一个基于组件样式的`class`来实现（例如，svelte-123xyz）。
```html
<style>
	p {
		/* this will only affect <p> elements in this component */
		color: burlywood;
	}
</style>
```
可以通过使用`:global(...)`修饰符将样式作用域全局。
```html
<style>
	:global(body) {
		/* this will apply to <body> */
		margin: 0;
	}

	div :global(strong) {
		/* this will apply to all <strong> elements, in any
			 component, that are inside <div> elements belonging
			 to this component */
		color: goldenrod;
	}
</style>
```