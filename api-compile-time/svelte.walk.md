### svelte.walk

```js
walk(ast: Node, {
	enter(node: Node, parent: Node, prop: string, index: number)?: void,
	leave(node: Node, parent: Node, prop: string, index: number)?: void
})
```

`walk` 函数提供了一种方法，可以通过编译器自己内置的 [estree-walker](https://github.com/Rich-Harris/estree-walker) 实例来遍历解析器生成的抽象语法树的方法。

```js
const svelte = require('svelte/compiler');
svelte.walk(ast, {
	enter(node, parent, prop, index) {
		do_something(node);
		if (should_skip_children(node)) {
			this.skip();
		}
	},
	leave(node, parent, prop, index) {
		do_something_else(node);
	}
});
```

遍历器需要传入一个抽象语法树以及一个对象（包含可选的两个方法：`enter` 和 `leave`）。对于每个节点，`enter` 会被调用（如果传入的对象中存在这个方法的话）。接下来，除非是 `this.skip()` 在 `enter` 方法中被调用，否则每个子节点都会被遍历，遍历完成后，`leave` 方法会在这个节点上被调用。