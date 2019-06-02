## 列表渲染（Each blocks）

```html
{#each expression as name}...{/each}

{#each expression as name, index}...{/each}

{#each expression as name, index (key)}...{/each}

{#each expression as name}...{:else}...{/each}
```

遍历一个数组，可以通过`列表渲染` 来实现。

```html
<h1>Shopping list</h1>
<ul>
	{#each items as item}
		<li>{item.name} x {item.qty}</li>
	{/each}
</ul>
```

每一个 `each  block` ，都可以指定一个 `index` 。 该index的作用和 `array.map()` 的回调方法的第二个参数相同。

```html
{#each items as item, i}
	<li>{i + 1}: {item.name} x {item.qty}</li>
{/each}
```

 如果你指定了 `key`，Svelte 会在数据发生变更的时候，对列表进行diff。

要注意，列表中的每一项的`key` 都必须是唯一的，`key` 可以是任何对象，但建议使用字符串和数字，因为它们允许在对象本身更改时保持标识。

```html
{#each items as item, i (item.id)}
	<li>{i + 1}: {item.name} x {item.qty}</li>
{/each}
```

您可以在每个块中使用es6的语法 : 解构:

```html
{#each items as { id, name, qty }, i (id)}
	<li>{i + 1}: {name} x {qty}</li>
{/each}
```

每个块还可以有一个 `{:else}` 子句，如果列表为空，则呈现该子句。

```html
{#each todos as todo}
	<p>{todo.text}</p>
{:else}
	<p>No tasks today!</p>
{/each}
```

