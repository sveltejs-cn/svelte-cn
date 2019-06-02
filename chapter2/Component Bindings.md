### 组件绑定

```html
bind:property={variable}

bind:this={component_instance}
```

可以使用相同的机制绑定到组件属性.

```html
<Keypad bind:value={pin}/>
```

组件同样支持 `bind:this`, 可以让你直接和组件实例交互。

> 注意，我们可以执行`{cart.empty}`而不是`{（）=>cart.empty（）}`，因为组件方法是闭包。当执行他们的时候，不需要担心。

```html
<ShoppingCart bind:this={cart}/>

<button on:click={cart.empty}>
	Empty shopping cart
</button>
```

