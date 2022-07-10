構式中的搭配：Collostruction
==========================


在前面的幾個段落裡，我們了解搭配語是出現在特定窗口大小 \index{窗口大小 (window size)}內的詞彙組。這個判斷方式已足以觀察到語料中一些穩定的現象，但卻未能利用語言的一項重要特性---語法關係 (syntactic relation) \index{語法關係 (syntactic relation)}...

關於
----

在語料庫語言學裡，這方面的研究有兩個略有差異的方向。這個方向就是語料庫工具 [Sketch Engine][sketch-engine] 中的詞彙素描 (word sketch) 背後的基礎 [@kilgarriff2004; @kilgarriff2014; @huang2005]，本書第八章有詳細介紹。第二個方向 [@stefanowitsch2003; @gries2004; @stefanowitsch2005] 則是受**構式語法** (Construction Grammar) \index{構式語法 (Construction Grammar)} [@goldberg1995] 的啟發，關注的是特定構式 \index{構式 (construction)}之下語法單位間的搭配關係。本章將著重介紹第二個方向。

[sketch-engine]: https://www.sketchengine.eu


### 資料準備

由於在搭配現象中引入了「語法」的概念，我們需要語法相關的資訊，亦即詞類標記 (part of speech, PoS) \index{詞類標記 (part of speech, PoS)}...

```bash
pip install -U ckiptagger[tf,gdown]
pip install -U concordancer
```

### 搜尋「把」字句

有了剛剛的準備，我們便能開始從語料中搜尋抽象的...

「把」字句的結構是「把 + (賓語) + (動作)」，例如，「把 **時間** (賓語) **花** (動作) 在」。下方是「把」字句的 CQL 結構，`[]` 內是在描述該詞...


上方這條搜尋語法裡面，定義了 3 個不同的 token：

1. `[word="把" & pos="P"]` 「把」這個詞（P 介詞，詳見[中研院詞類表][ckiptags]）
2. `[pos="N[abcd].*"]` 名詞（以 `Na/Nb/Nc/Nd` 開頭的詞類）
3. `[pos="V.*"]` 動詞（所有以 `V` 開頭的詞類)

語言複雜的程度總是超過我們的想像。事實上，上方的搜尋語法只能搜尋到**一部分的「把」字句**，因為它忽略了其它的可能，例如「**把** 寶貴 的 **時間** **花** 在」這個把字句不符...


[kwic-wiki]: https://en.wikipedia.org/wiki/Key_Word_in_Context
[ckiptags]: https://github.com/ckiplab/ckiptagger/wiki/POS-Tags
