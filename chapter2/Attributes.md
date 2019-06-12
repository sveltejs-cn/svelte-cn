### Attributes

默认情况下，模板的属性，与其对应的 HTML 属性完全相同。

```html
<div class="foo">
    <button disabled>can't touch this</button>
</div>
```

与 HTML 一样，属性值可能不加引号。

```html
<input type=checkbox>
```

属性值可以包含`javascript`的表达式：

```html
<a href="page/{p}">page {p}</a>
```

或者，属性值本身就是`javascript`的表达式：

```html
<button disabled={!clickable}>...</button>
```

需要注意的是，`javascript`的表达式中，可能会包含一些字符，这些字符会让普通的`html` 代码无法被语法高亮，所以我们可以使用 `引号`。 

`引号` 不会影响 属性值的解析。

```html
<button disabled="{number !== 42}">...</button>
```
当属性名和值匹配(`name= {name}`)时，可以用`{name}`来代替它们。

```html
<!-- These are equivalent -->
<button disabled={disabled}>...</button>
<button {disabled}>...</button>
```

扩展属性可以有多个属性，这些属性可一次性传递给元素或组件。

元素或组件可以具有多个扩展属性，其中可以包含常规的属性。

```html
<Widget {...things}/>
```

