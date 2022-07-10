又是一章
========

簡介
-------

接下來，讓我們利用「把」字句的資料進行構式中的搭配分析 (Collostruction Analysis)。以下將會介紹三種量化方式，分別為 Collexeme Analysis [@stefanowitsch2003]、Covarying Collexeme Analysis [@stefanowitsch2005]，以及 Distinctive Collexeme Analysis [@gries2004]。


### 構式與詞彙的互相吸引

Collexeme Analysis 用於衡量構式與其空槽 (lexical slot) 內的詞彙的共現傾向。例如：可以藉由此種分析方式得知什麼詞彙特別容易做為**賓語**出現在「把」字句中。Collexeme Analysis 透過列聯表量化構式與詞彙互相吸引的程度。以 @tbl:collexeme-analysis1 為例，透過此列...

|       |   錢      |   ~錢    |  Total  |
| :---: | :------: | :------: | :-----: |
| 把字句  | $O_{11}$ | $O_{12}$ | $R_{1}$ |
| ~把字句 | $O_{21}$ | $O_{22}$ | $R_{2}$ |
| Total | $C_{1}$  | $C_{2}$   |   $N$   |

Table: 「把字句」(構式) 與「錢」(賓語) 的列聯表 {#tbl:collexeme-analysis1}

要計算出 @tbl:collexeme-analysis1 內每個項目的頻率，除了搜尋得來的「把」字句的共現環境 (concordance) 之外，還需要一些額外的資訊。首先，`concordancer` 所找出的把字句筆數，即是 @tbl:collexeme-analysis1 的 $R_{1}$ ，而 $O_{11}$ 則是賓語「錢」在這些把字句中出現的頻率。透過 $R_{1}$ 與 $O_{11}$ ，即可以算出 $O_{12}$，也就是 $R_{1}$ - $O_{11}$。$C_{1}$ 則...

```python
{
    'L1': { 'o11': freq, 'all': freq },
    'L2': { 'o11': freq, 'all': freq },
    'L3': { 'o11': freq, 'all': freq },
    ...
}
```

### 構式之中的詞彙搭配：Covarying Collexeme Analysis

衡量同一句式下的兩個 lexical slots 內的詞彙的共現傾向
e.g., 「把」字句中的賓語與動作，如：把 時間(slot1) 花(slot2) 在...

### 量化相似構式之間的差異：Distinctive Collexeme Analysis

比較兩種 (or 多種) 句式中，相應位置之 lexical slot 的偏好
e.g., 「把」字句 vs.「將」字句，句中之動詞使用偏好


### Custom Box

::: {.Box title="自訂區塊標題"}
這是 **Box** 裡面的*段落*。這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。

Markdown content and other blocks are enabled, e.g., code:

```python
print("Custom code block")
```

這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。這是 Box 裡面的段落。This is a custom block. This is a custom block. This is a custom block. 
:::::::::::
