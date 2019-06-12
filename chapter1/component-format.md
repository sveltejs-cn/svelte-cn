# 在开始之前：

注意：此文档目前还是半成品。如遇到缺失或有误导的部分敬请谅解，并且勇于在聊天室寻求帮助，这些教程会更加完善。那么，开始学习吧：

以下页面包含详细的API说明文档，主要是给已经初步接触过Svelte的人们提供的资源。

如果你还没有接触过Svelte，你可以在查阅这些资料前先访问这个可交互的教程或者例子。

# 组件格式

组件是 Svelte 应用的内置区块，是使用 HTML 的扩展格式的语言写成`.svelte`文件

一共分为三个区域: `script`、`style`和`标签`, 每一个部分都是选填的。

## script

`<script>`中的 javascript 代码，将在组件实例被创建时执行。
在组件标签顶部显式的申明变量（或者导入变量），这里有4条规则：

1. `export`创建组件的属性

Svelte 使用`export`关键字将一个变量声明标记为组件的`属性`或`prop`，这意味着组件的使用者可以直接访问这些变量:

```
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

2. 赋值是『响应式』的

要改变组件的状态`state`并触发组件的重新渲染，只需要给已申明变量重新赋值

使用表达式（`count += 1`）更新`count`的值，和属性赋值（`obj.x = y`）是等效的。

因为 Svelte 的『响应式特性』是基于赋值的，因此使用`.push`和`.splice`将不会自动触发更新。有关解决此问题的选项，可以参考此[教程](https://svelte.dev/tutorial/updating-arrays-and-objects)

```
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

任何顶层的表达式（不在块级作用域中，或函数申明中），都可以通过在前面添加`$：`前缀来使其成为响应式的。这是js的标签语法。只要它们所依赖的值发生更改，响应式语句就会在组件更新之前立即运行。

如果一个表达式是一条由完全未申明的变量组成的赋值语句，Svelte 会替你插入一个let申明。

```
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

4 为 Store 添加`$`前缀来访问它们的值

任何时候，对于任意一个 Store，你都可以在组件内部为该 Store 的引用添加$字符前缀来访问它的值。这会导致 Svelte 申明有前缀的变量，并且会设置一个 Store 订阅, 然后在适当的时候会取消这个订阅。

要注意，必须在组件的顶层申明 Store，并且不可以包含在`if`代码块中

本地申明的变量（不代指 Store 的值）不允许还有$前缀

## <script context="module">

一个带有`context="module"`属性的`<script>`标签的模块只会执行一次，而不是每次都生成组件实例。在此模块中申明的Values可以被正常的`<script>`标签访问到（包括组件标签）但是反之则无法这么使用。

你可以从此区块中 导出 这些绑定值，并且他们会成为编译的模块的导出值

你不能 `export default` 因为默认导出的是组件本身


## <style>

`<style>`中的CSS, 与组件外部是隔离的

原理是，给元素添加带有组件style哈希的class来实现的。比如说`svelte-123xyz`

可以通过使用`:global(...)`修饰符将样式作用域全局


