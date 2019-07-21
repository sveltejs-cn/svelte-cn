### Slots
```html
<slot><!-- optional fallback --></slot>
```
```html
<slot name="x"><!-- optional fallback --></slot>
```
```html
<slot prop={value}></slot>
```
和原生的 DOM 元素一样，组件在使用的时候也可以有子内容。

子内容会替代在组件中使用 `<slot>` 包裹的内容，如果没有向插槽提供内容的时候，`<slot>` 包裹的内容会作为默认内容返回。

```html
<!-- App.svelte -->
<Widget>
	<p>this is some child content</p>
</Widget>

<!-- Widget.svelte -->
<div>
	<slot>
		this will be rendered if someone does <Widget/>
	</slot>
</div>
```

具名插槽允许开发者指定特定插槽的内容，当然他们也可以有默认内容。

```html
<!-- App.svelte -->
<Widget>
	<h1 slot="header">Hello</h1>
	<p slot="footer">Copyright (c) 2019 Svelte Industries</p>
</Widget>

<!-- Widget.svelte -->
<div>
	<slot name="header">No header was provided</slot>
	<p>Some content between header and footer</p>
	<slot name="footer"></slot>
</div>
```

插槽可渲染零次或多次，可通过 `props` 把值回传给父级。父级可以可以通过 `let:` 指令把值传给插槽模版。

常用简洁的方式来写- `let:item` 表示 `let:item={item}` ，而且 `<slot {item}>` 等同于 `<slot item={item}>`。

```html
<!-- App.svelte -->
<FancyList {items} let:item={item}>
	<div>{item.text}</div>
</FancyList>

<!-- FancyList.svelte -->
<ul>
	{#each items as item}
		<li class="fancy">
			<slot item={item}></slot>
		</li>
	{/each}
</ul>
```

具名插槽也可以暴露一个值给父级，通过在元素上使用对应的 `let:` 指令获取暴露的属性。

```html
<!-- App.svelte -->
<FancyList {items}>
	<div slot="item" let:item={item}>{item.text}</div>
	<p slot="footer">Copyright (c) 2019 Svelte Industries</p>
</FancyList>

<!-- FancyList.svelte -->
<ul>
	{#each items as item}
		<li class="fancy">
			<slot name="item" item={item}></slot>
		</li>
	{/each}
</ul>

<slot name="footer"></slot>
```