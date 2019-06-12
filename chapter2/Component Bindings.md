### Component bindings

```html
bind:property={variable}
```

```html
bind:this={component_instance}
```

你可以使用相同的机制给组件绑定属性。

```html
<Keypad bind:value={pin}/>
```

组件还支持`bind:this`，允许你以动态数据的方式与组件实例进行交互。

> 注意，当按钮首次渲染的时候，我们不能使用`{cart.empty}`，因为`cart`还是`undefined`，这样会抛出异常。

```html
<ShoppingCart bind:this={cart}/>

<button on:click={() => cart.empty()}>
	Empty shopping cart
</button>
```

