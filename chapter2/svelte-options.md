### `svelte-options`

```html
<svelte:options option={value}>
```

```html
<svelte:options tag="my-custom-element"/>
```

`<svelte：options>`提供了一个地方去指定每一个组件的编译的选项，相关内容在编译器部分有详细介绍。支持的选项有：

- `immutable={true}`-表示你将不会使用可变的数据，如果值发生改变的时候，编译器会依据指向是否相等的简单检查
- `immutable={false}`-默认值。对于可变对象是否发生了变化，Svelte会更加保守。
- `accessors={true}`- 为组件的`props`添加`getters`和`setters`
- `accessors={false}`— 默认值
- `namespace="..."`-指定命名空间，当组件被使用的时候，最常见的是`svg`
- `tag="..."`-将此组件编译为自定义元素时使用的名称