### 属性(Attributes)

默认情况下，模板的属性，和其对应的html属性几乎一模一样。

```html
<div class="foo">
	<button disabled>can't touch this</button>
</div>
```

和 `html` 中一样，属性值也可以不被`引号`包裹。

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

需要注意的是，`javascript`的表达式中，可能会包含一些字符，这些字符会让普通的`html` 代码无法被语法高亮，所以，我们可以使用 `引号`。 

`引号` 不会影响 属性值的解析。

```html
<button disabled="{number !== 42}">...</button>
```

当属性名和值匹配（`name= {name}`）时，可以将它们替换为`{name}`。

```html
<!-- These are equivalent -->
<button disabled={disabled}>...</button>
<button {disabled}>...</button>
```

扩展属性（*Spread attributes* ）允许同时将许多属性或属性传递给元素或组件。

一个元素，或者组件，可以有多个扩展属性。并且拓展属性和正常的html 属性可以共存。

```html
<Widget {...things}/>
```

