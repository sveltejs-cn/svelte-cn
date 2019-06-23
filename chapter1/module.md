### &lt;script content="module"&gt;

具有`context =“module”`属性的`<script>`的模块在首次解析时运行一次，而不是每个组件实例都运行一次。在此类型的模块中申明的`Values`可以被普通的`<script>`标签访问到（包括组件标签）但是相反则无法这么使用。
你可以从此模块中`export`这些绑定值，并且他们会成为编译过的模块的导出值
你无法`export`默认值，因为默认导出的是组件本身。
```html
<script context="module">
	let totalComponents = 0;

	// this allows an importer to do e.g.
	// `import Example, { alertTotal } from './Example.svelte'`
	export function alertTotal() {
		alert(totalComponents);
	}
</script>

<script>
	totalComponents += 1;
	console.log(`total number of times this component has been created: ${totalComponents}`);
</script>
```