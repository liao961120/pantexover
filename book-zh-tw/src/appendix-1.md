R 基礎
===============


R 語言是從統計社群開發出來的語言，比較傑出的地方在於統計相關的計算與製圖。近年來由於幾位知名的語言學家的大力推廣，使 R 語言成為語料庫語言學研究的主流程式語言之一。開源的開發環境 RStudio 的出現，更是使得R語言的編程與專案協作，甚至與 web app (shiny) 的開發工作更加便利迅速。R語言社群對於資料處理的套件開發速度也相當驚人，還有許多進階的統計計算與作圖套件方便研究者從事量化的語音與文本分析。

## 向量
R 以向量（vector）當作基本單位，在Python中的「一個變數的回傳值」，在 R 中的概念其實是「一個長度為 1 的向量」。而 R 的 vector 又分成 6 種類別，其中較常見的 4 種為 `integer`, `double`, `character`, `logical`。

1. integer vector 的元素由整數組成，可以是零、正數或負數。 
    - 除了使用`:` 製造數列，也可以使用 `c()` (稱為 concatenate) 組出任意序列的 vector。
    - 使用 `c()` 製造 integer vector 時，每個整數數字後面必須接 `L`，若沒有加上 `L`， R 會將製造出來的 vector 視為 double vector。
2. double vector 的元素由浮點數組成，亦即含有小數點的數字 (e.g 1.2, -0.75)
    - double vector 和 integer vector 合稱 numeric vector，通常不太需要區別兩者，因為 R 在運算時，會將這兩種資料類型自動轉換成合適的類型。
3. character vector 的每個元素皆由一個字串組成。
    - R 也可以儲存字串 (string)。在 R 裡面，只要是被引號 (quote, ' 或 " 皆可) 包裹的東西就是字串，放在引號內的可以是任何字元 (e.g. 空白、數字、中文字、英文字母)。
    - 如果字串內含有引號 "，需在字串內的引號前使用跳脫字元 \，以表示此引號是字串的一部分而非字串的開頭或結尾。也可以使用「不同的」引號，弱勢以「單引號」表示字串的開頭與結尾時，字串內就可以直接使用「雙引號」，反之亦然。
4. logical vector 的每個元素由 TRUE 或 FALSE 組成。
    - 可以使用 c() 一項項手動輸入製造 logical vector，另一個來源則是 logical test 的回傳值：
    - boolean operators (&, |, !, any(), all()) 可以整合多個 logical tests
    - logical operators: ==, !=, >, <, %in%

在 R 運算兩個或兩個以上的 vector 時，通常以 element-wise 的方式進行。若 vector 長度不相同，例如`c(1, 2, 3) + 2`， R 會自動將長度較短 vector (2) 回收（recycle），也就是重複此向量內的元素，拉長到與另一個 vector 等長，再將兩個一樣長的 vector 進行 element-wise 的向量運算。vector 內的每個元素，其資料類型（data type）必須相同。資料類型即是前面提到的 integer, double, character, logical。若資料類型不一致（例如：將不同資料類型的元素放入 c()），R 會根據某些規則，自動進行資料類型的轉換。

### 向量中的元素
我們可以透過 3 種方式來取出 vector 裡的元素，傳回一個新的 vector。第一種方式是透過元素在 vector 中的位置次序 (index)：
```r
# LETTERS 是 R 內建變數: 一個包含所有大寫英文字母的 character vector

LETTERS[1]
#> [1] "A"

LETTERS[1:5]
#> [1] "A" "B" "C" "D" "E"

LETTERS[c(1, 3, 5)]
#> [1] "A" "C" "E"
```

## 前處理與 stringr 套件

正如本書第三章介紹在 Python 的文字前處理方式，我們也可以使用 R 來進行。透過各程式語言通用的 Regex 以及 R 的 stringr 套件，我們可以撰寫合適的 function 來清理語料。

我們先來認識 stringr 這個套件。它是 tidyverse 套件中負責處理字串的套件，比起 base R 的字串處理函數，stringr 中的函數名稱較一致（str_*）。在 R 裡面，Regex 是以字串（character）的資料類型來表徵，因此需注意：若是 Regex 包含反斜線，則需要在每一個反斜線之前再加上一個反斜線。舉例來說，在 Python 我們要跳過`.`這個字元時，會寫作 `today\.$`，但在 R 中就必須寫成`today\\.$`。

`str_detect()` 是一個常用的 stringr 函數。若是我們想知道向量 `s <- c("cat", "bed", "car", "Mr.")` 中，哪些元素擁有字串 a 時，就可以使用 `str_detect(s, "a")`，則程式會回傳一個logical vector `[1]  TRUE FALSE  TRUE FALSE`。`str_detect()`也可結合 [ ] 或 dplyr 套件中的 filter() 函數，來篩選出元素的值：
```r
s <- c("cat", "bed", "car", "Mr.")
s[str_detect(s, "^c")]

#> [1] "cat" "car"
```


## 中文文本資料處理

### 斷詞
jieba 是一個用於中文斷詞的 Python 套件。jiebaR 則是 jieba 的 R 版本。透過 jiebaR 進行斷詞只需要兩個步驟：使用 `worker()` 初始化斷詞設定，再使用 `segment()` 將文字斷詞。`jiebaR::segment()` 會回傳一個 character vector，vector 內的每個元素都是一個被斷出來的詞：
```r
library(jiebaR)
seg <- worker()
txt <- "失業的熊讚陪柯文哲看銀翼殺手" 
segment(txt, seg)

#> [1] "失業" "的熊" "讚" "陪" "柯文" "哲看" "銀翼" "殺手"
```
遇到專有名詞或是特殊詞彙時，jiebaR 的斷詞可能會不太精準。若想避免這種情況，可以新增一份自訂辭典（儲存在一份純文字檔，每個詞佔一行），例如我們的自訂辭典 `user_dict.txt` 的內容如下：


### tidytext 套件
至於 tidytext 則是一個較近期的 text mining 套件，它將 tidyverse 的想法運用到文本資料處理，換言之，它使用 data frame 的資料結構去表徵和處理文本資料。若是我們使用 tidytext 處理文本資料，能在文本分析的過程中結合 dplyr 與 ggplot2，快速地視覺化文本資料。

不過在 tidytext framework 之下，文章的內部（詞彙與詞彙之間的）結構會消失，因為一段文本對於 tidytext 來說就是 bag-of-words。由於 tidytext 儲存文本資料的格式是 one-token-per-document-per-row，在一個 data frame 中，每個row 是一篇文章中的一個 token。舉例來說，如果我們有兩篇文章，第一篇被斷成 38 個詞彙，第二篇被斷成 20 個詞彙，則我們總共需要一個擁有 58 rows 的 data frame 來儲存這兩篇文章。

一般而言，tidytext 的架構適合詞頻相關的分析，像是計算文章的 lexical diversity，或是透過詞頻進行情緒分析。透過 `tidytext::unnest_tokens()`，我們可以將 `docs_df` 儲存的文本資料（已斷詞），變成 tidytext format，也就是 one-token-per-document-per-row 的 data 

## 向量表徵

由於資料科學以及統計學方法上的限制，我們要對文本進行量化分析之前，常常要將原本以符碼 (文字) 表徵的文本轉成數值表徵，才能對文本進行相似度計算、分群、分類等等分析。將文本轉換成數值的表徵方式相當多，其中一種最簡單的方式，即是使用 document-term matrix 將文本以數值向量去表徵。


```r
#' doc1:	"I baked the cake and the muffin"
#' doc2:	"I loved the cake"
#' doc3:	"I wrote the book"
#' TERMS:        I  baked loved wrote the and cake muffin book
dtm <- matrix(c( 1,   1,    0,    0,   2,  1,   1,    1,   0 ,
                 1,   0,    1,    0,   1,  0,   1,    0,   0 , 
                 1,   0,    0,    1,   1,  0,   0,    0,   1 ), 
              nrow = 3, ncol = 9, byrow = TRUE)

dtm
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
#> [1,]    1    1    0    0    2    1    1    1    0
#> [2,]    1    0    1    0    1    0    1    0    0
#> [3,]    1    0    0    1    1    0    0    0    1
```
有了文本的向量表徵之後，我們就能去量化比較文本之間的相似度，方法是直接利用向量之間的距離公式 $d(\overrightarrow{p}, \overrightarrow{q})$ 以及相似度公式 $cos(\theta)$：

$$
d(\overrightarrow{p}, \overrightarrow{q}) = \sqrt{ (p_1 - q_1)^2 + (p_2 - q_2)^2 + ... + (p_n - q_n)^2 }
$$

$$
cos(\theta) = \frac{\overrightarrow{p} \cdot \overrightarrow{q}}{\lVert p \rVert \lVert q \rVert }
$$

### Latent Semantic Anlysis (Dimensionality Reduction)

由於 document-term matrix 通常很稀疏，很多值會是 0，使文本向量無法抓到某些文本之間的語意關聯。比如 doc2 與 doc4 雖然語意相近，但此二文本的向量的相似度 (cosine similarity) 為零，因為這兩篇文本並未使用到相同的詞彙。面對這種情形，我們可以將高維的 document-term matrix 透過數學方式轉換成維度比較小的矩陣。在這個過程中，document-term matrix 中一些語意相近的詞彙會被壓縮到某個或是某些維度中，讓這個維度比較小的矩陣反而比較能表徵文本之間的語意關聯。這種方式稱為 Latent Semantic Analysis (LSA)，而用來將矩陣分解降維的數學方法稱為 Singular Value Decomposition (SVD)。

```r
lsa_model <- quanteda.textmodels::textmodel_lsa(q_dfm, nd = 15)
dim(lsa_model$docs)
#> [1] 300  15

# Document similarity
doc_sim2 <- textstat_simil(as.dfm(lsa_model$docs), method = "cosine")
sort(doc_sim2["anti_1.txt", ], decreasing = T)[1:8]
#>   anti_1.txt    pro_2.txt anti_102.txt anti_146.txt   pro_94.txt   pro_84.txt 
#>    1.0000000    0.9963039    0.9959590    0.9936474    0.9933724    0.9933206 
#>  anti_94.txt  pro_133.txt 
#>    0.9923490    0.9921601
```
