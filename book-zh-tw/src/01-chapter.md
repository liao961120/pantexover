語料中的搭配現象
=============

語言是一個能夠攜帶並表達意義的系統。為了能傳達意義...

一般來說，語言中的規律可以出現在任何一個語言單位上 (語音、詞素、字、詞彙、句子、篇章等)[^1]，但傳統上，語料庫語言學關注的焦點是**詞彙**...要理解這兩種組合的差異相當簡單---我們知道礦泉水通常是以「瓶子」去盛裝，而較少以鍋子盛裝[^2]...

上述所舉的例子在語言學中稱為**搭配語** \index{搭配語 (collocation)} (collocation)。定義上...：
$p(瓶) \times p(礦泉水) = \frac{41}{50000} \times \frac{13}{50000} = 2.132 \times 10^{-7}$
，「鍋」與「礦泉水」搭配出現的機率會是：
$p(鍋) \times p(礦泉水) = \frac{39}{50000} \times \frac{13}{50000} = 2.028 \times 10^{-7}$
。此時，我們便可以**將隨機排序當作基準**與**實際的資料**進行比較：

$$
\begin{aligned}
\frac{ p(瓶, 礦泉水) }{ p(瓶) p(礦泉水)} &= \frac{ 11/13 }{ 2.132 \times 10^{-7} } = 3968826.671 \\
\\
\frac{ p(鍋, 礦泉水) }{ p(鍋) p(礦泉水)} &= \frac{ 1/13 }{ 2.028 \times 10^{-7} } = 379305.113
\end{aligned}
$$ {#eq:pmi1}

這些數值可以直觀地詮釋為...


[^1]: 因為語言不論在哪個單位...
[^2]: 當然，在現實世界中或許礦泉水**沒有**較...


值得注意的是，搭配現象不只適用在詞彙單位上...至**構式** \index{構式 (construction)} (construction)。


詞彙之間的搭配：搭配語 (Collocation)
--------------------------------

### 操作化「搭配」現象：列聯表 (Contingency Table)

舉例來說，下方的資料中共有 6 筆觀察值，記錄了 6 個人的資訊，並包含兩個類別變項 (1) **教育程度**以及 (2) **性別**：

|  id   | 教育程度 | 性別  |
| :---: | :------: | :---: |
|   1   |   國中   |  男   |
|   2   |  高中職  |  女   |
|   3   |   碩士   |  女   |
|   4   |   大專   |  女   |
|   5   |   大專   |  男   |
|   6   |  高中職  |  男   |

若想知道教育程度與性別有無關聯...

|       | 國中  | 高中職 | 大專  | 碩士  |
| :---: | :---: | :----: | :---: | :---: |
|  男   |   1   |   1    |   1   |   0   |
|  女   |   0   |   1    |   0   |   2   |


搭配語的程式實作
--------------

### 節點詞與搭配詞

前文在介紹搭配現象時，並未特別區分節點詞 (node word) \index{節點詞 (node word)} 與搭配詞 (collocate) \index{搭配詞 (collocate)} ...

![節點詞與搭配詞](figures/ch07_collocation_window.png){#fig:ch07-sliding-window-0}

了解「節點詞/搭配詞」的定義後，我們以滑動窗口的演算法計算句中各種 `(節點詞, 搭配詞)` 組合出現的次數 (見 @fig:ch07-sliding-window)...

![以滑動窗口演算法計算句中「節點詞/搭配詞」組合次數](figures/ch07_collocation_sliding_window.png){#fig:ch07-sliding-window}


```python
def count_freq_sent(sentence, left_window, right_window):
    cooccur_freq = {} # 共現頻率資料
    sent_len = len(sentence)
    return cooccur_freq
```

在 `count_freq_sent()` 函數中，內層 for 迴圈的第三行是 `k = (node, collocate)`。因此，詞組內的第一個詞是節點詞，第二個詞是搭配詞，並非依照詞彙於句中出現的順序排列。例如：`('葡萄', '吃')` ...

在上方程式碼中，我們將左右窗口大小皆設為 2，因此搭配詞可能會出現在節點詞之前或之後。事實上，左右窗口的大小不一定要相同，依據目的不同，可以填入不一樣的左右窗口。舉例來說，有時候我們感興趣的是出現在節點詞**後方**的搭配詞...


### 量化搭配強弱 

我們要計算的列聯表如 @tbl:collocation-contingency 與 @tbl:collocation-contingency-2。$O_{11}$、$O_{12}$、$O_{21}$、$O_{22}$ 為各種組合之下的頻率觀察值；$R_{1}$、$R_{2}$、$C_{1}$、$C_{2}$ 則為邊際頻率 (marginal frequency)。

|       |    Wc    |   ~Wc    |  Total  |
| :---: | :------: | :------: | :-----: |
|  Wn   | $O_{11}$ | $O_{12}$ | $R_{1}$ |
|  ~Wn  | $O_{21}$ | $O_{22}$ | $R_{2}$ |
| Total | $C_{1}$  | $C_{2}$  |    N    |

Table: 節點詞/搭配詞列聯表 (實際頻率) {#tbl:collocation-contingency}

|       |                Wc                |               ~Wc                |  Total  |
| :---: | :------------------------------: | :------------------------------: | :-----: |
|  Wn   | $E_{11} = \frac{R_{1} C_{1}}{N}$ | $E_{12} = \frac{R_{1} C_{2}}{N}$ | $R_{1}$ |
|  ~Wn  | $E_{21} = \frac{R_{2} C_{1}}{N}$ | $E_{22} = \frac{R_{2} C_{2}}{N}$ | $R_{2}$ |
| Total |             $C_{1}$              |             $C_{2}$              |    N    |

Table: 節點詞/搭配詞列聯表 (頻率期望值) {#tbl:collocation-contingency-2}

如果我們想知道 `(節點詞：電影, 搭配詞：日本)` 這個組合在 `corpus` 中的搭配情形，可以先列出以下列聯表：


$$
\begin{aligned}
MI       &= log2(\frac{O_{11}}{E_{11}}) \\
\\
\chi^2   &= \sum_{j} \frac{ (O_{j} - E_{j})^2 }{ E_{j} } \\
         &= \frac{ (O_{11} - E_{11})^2 }{ E_{11} } +
            \frac{ (O_{12} - E_{12})^2 }{ E_{12} } +
            \frac{ (O_{21} - E_{21})^2 }{ E_{21} } +
            \frac{ (O_{22} - E_{22})^2 }{ E_{22} } \\
\\
G^2      &= 2 \sum_{j}{O_{j}log\frac{O_{j}}{E_{j}}} \\
         &= 2 (O_{11}log\frac{O_{11}}{E_{11}} +
               O_{12}log\frac{O_{12}}{E_{12}} +
               O_{21}log\frac{O_{21}}{E_{21}} +
               O_{22}log\frac{O_{22}}{E_{22}})
\end{aligned}
$$ {#eq:association-measures}



