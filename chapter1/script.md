### script
`<script>`标签里面含有一个组件实例创建时的运行Javascript代码。
在组件标签顶部显示申明变量（或者导入变量），这里有4条规则：

1. `export`创建组件的属性

`Svelte`使用`export`关键字将一个变量申明标记为组件的`属性`或`prop`，这意味着组件的使用者可以直接访问这些变量:

```html
<script>
	// these properties can be set externally
	export let foo;
	export let bar = 'optional default value';

	// you can use export { ... as ... } to have
	// props whose names are reserved keywords
	let clazz;
	export { clazz as class };

	// this property is readonly externally
	export const buzz = 'buzz';

	// Values that are passed in as props
	// are immediately available
	console.log(foo, bar);

	// Function expressions can also be props
	export let format = (number) => (number.toFixed(2));

	// Function declarations are added as methods
	// on the component, rather than props
	export function greetMethod() {
		alert(`I'm a <${this.constructor.name}>!`);
	}

	// you can also use export { ... as ... } to have
	// methods whose names are reserved keywords
	function del() {
		do_something();
	}
	export { del as delete };
</script>
```

2. 赋值是`响应式`的

要改变组件的状态`state`并触发组件的重新渲染，只需要给已申明变量重新赋值

使用表达式（count += 1）更新count的值和属性赋值（obj.x = y）是等效的。

因为`Svelte`的`响应式特性`是基于赋值的，因此使用`.push`和`.splice`将不会自动触发更新。有关解决此问题的选项，可以参考此[教程](https://svelte.dev/tutorial/updating-arrays-and-objects)

```html
<script>
	let count = 0;

	function handleClick () {
		// calling this function will trigger a re-render
		// if the markup references `count`
		count = count + 1;
	}
</script>
```

3 使用`$:`将表达式设为响应式的

任何顶层的表达式（不包含块级作用域里面和函数申明里面）都可以通过在前面添加`$：`前缀来使其成为响应式的。这是js的标签语法。只要它们所依赖的值发生更改，响应式语句就会在组件更新之前立即运行。

如果一个表达式是一条由完全未申明的变量组成的赋值语句，Svelte会替你插入一个let申明。

```html
<script>
	export let title;

	// this will update `document.title` whenever
	// the `title` prop changes
	$: document.title = title;

	$: {
		console.log(`multiple statements can be combined`);
		console.log(`the current title is ${title}`);
	}
</script>
```

4 为Store添加$前缀来访问它们的值

任何时候，对于任意一个Store，你都可以在组件内部为该Store的引用添加$字符前缀来访问它的值。这会导致Svelte申明有前缀的变量，并且会设置一个Store订阅然后再适当的时候会取消这个订阅。

要注意，必须在组件的顶层申明Store，并且不可以包含在if代码块中

本地申明的变量（不代指store的值）不允许还有$前缀