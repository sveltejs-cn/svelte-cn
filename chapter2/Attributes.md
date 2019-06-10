### Attributes

默认情况下，模板属性的工作方式，与其对应的 HTML 属性完全相同。

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

一个表达式中可能会有导致常规的 HTML 语法出错，从而语法高亮的字符，所以允许对属性的值使用引号。引号并不会影响属性值的解析方式。
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

