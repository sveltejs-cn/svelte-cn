## Each blocks

```html
{#each expression as name}...{/each}
```
```html
{#each expression as name, index}...{/each}
```
```html
{#each expression as name, index (key)}...{/each}
```
```html
{#each expression as name}...{:else}...{/each}
```

可以使用`each`来遍历一个列表数据。

```html
<h1>Shopping list</h1>
<ul>
	{#each items as item}
		<li>{item.name} x {item.qty}</li>
	{/each}
</ul>
```

每一个`each`块，都可指定`index` 。 `index`的值和`array.map(...)`的回调方法的第二个参数相同。

```html
{#each items as item, i}
	<li>{i + 1}: {item.name} x {item.qty}</li>
{/each}
```
如果你指定了`key`(必须是该列表中每一项的唯一标示)，Svelte 会在数据发生变更的时候，对列表进行 diff（而不只是在结尾添加或删除项）。
`key`可以是任何对象，但是推荐使用字符或数字，因为它们在对象发生变化的时候仍保持不变。

```html
{#each items as item, i (item.id)}
	<li>{i + 1}: {item.name} x {item.qty}</li>
{/each}
```

你可以在`each`中使用解构的语法。
```html
{#each items as { id, name, qty }, i (id)}
	<li>{i + 1}: {name} x {qty}</li>
{/each}
```

每个`each`也可以有一个`{:else}`部分，如果列表为空，则会渲染该部分的内容。

```html
{#each todos as todo}
	<p>{todo.text}</p>
{:else}
	<p>No tasks today!</p>
{/each}
```

