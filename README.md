# Block Diagonal Representation (BDR)

## Introduction

In our work <a class="footnote-reference" href="#id2" id="id1">[1]</a>, we present a unnified theory for the pursuit of the block diagonal matrix structure for subspace clustering (this part is extended from our former work <a class="footnote-reference" href="#id2" id="id1">[2]</a>). We also propose the first k-block diagonal regularizer for a direct pursuit of the block diagonal matrix. We then apply it for subpace clustering and name this method as Block Diagonal Representation (BDR). 

Assume that <a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{B}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{B}" title="\mathbf{B}" /></a>  is an affinity matrix, i.e., <a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{B}\geq&space;0" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{B}\geq&space;0" title="\mathbf{B}\geq 0" /></a> and <a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{B}=\mathbf{B}^\top" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{B}=\mathbf{B}^\top" title="\mathbf{B}=\mathbf{B}^\top" /></a>, the corresponding Laplacian matrix, denoted as <a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{L}_{\mathbf{B}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{L}_{\mathbf{B}}" title="\mathbf{L}_{\mathbf{B}}" /></a>, is defined as
<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{L}_{\mathbf{B}}=\text{Diag}(\mathbf{B\mathbf{1}})&space;-&space;\mathbf{B}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{L}_{\mathbf{B}}=\text{Diag}(\mathbf{B\mathbf{1}})&space;-&space;\mathbf{B}" title="\mathbf{L}_{\mathbf{B}}=\text{Diag}(\mathbf{B\mathbf{1}}) - \mathbf{B}" /></a>. Then the <a href="https://www.codecogs.com/eqnedit.php?latex=k" target="_blank"><img src="https://latex.codecogs.com/gif.latex?k" title="k" /></a>-block diagonal regularizer is defined as the sum of the <a href="https://www.codecogs.com/eqnedit.php?latex=k" target="_blank"><img src="https://latex.codecogs.com/gif.latex?k" title="k" /></a> smallest eigenvalues of <a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{L}_{\mathbf{B}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{L}_{\mathbf{B}}" title="\mathbf{L}_{\mathbf{B}}" /></a>, i.e.,

<p align="center"> 
<a href="https://www.codecogs.com/eqnedit.php?latex={\|\mathbf{B}\|}_k&space;=&space;\sum_{i=n-k&plus;1}^{n}\lambda_i(\mathbf{L}_{\mathbf{B}})." target="_blank"><img src="https://latex.codecogs.com/gif.latex?{\|\mathbf{B}\|}_k&space;=&space;\sum_{i=n-k&plus;1}^{n}\lambda_i(\mathbf{L}_{\mathbf{B}})." title="{\|\mathbf{B}\|}_k = \sum_{i=n-k+1}^{n}\lambda_i(\mathbf{L}_{\mathbf{B}})." /></a> 
</p>



It can be seen that <a href="https://www.codecogs.com/eqnedit.php?latex=\|{\mathbf{B}}\|_k=0" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\|{\mathbf{B}}\|_k=0" title="\|{\mathbf{B}}\|_k=0" /></a> is equivalent to the fact
that the affinity matrix <a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{B}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{B}" title="\mathbf{B}" /></a> is <a href="https://www.codecogs.com/eqnedit.php?latex=k" target="_blank"><img src="https://latex.codecogs.com/gif.latex?k" title="k" /></a>-block diagonal. So <a href="https://www.codecogs.com/eqnedit.php?latex=\|{\mathbf{B}}\|_k" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\|{\mathbf{B}}\|_k" title="\|{\mathbf{B}}\|_k" /></a> can be regarded as the block diagonal matrix structure induced regularizer.



<p align="center"> 
<img src="https://github.com/canyilu/Block-Diagonal-Representation-for-Subspace-Clustering/blob/main/fig_block_diagonal_matrix.JPG" width = '600'>
</p>

<p align="center"> 
<img src="https://github.com/canyilu/Block-Diagonal-Representation-for-Subspace-Clustering/blob/main/figure_block_diagonal_example.JPG" width = '600'>
</p>






## References

<table class="docutils footnote" frame="void" id="id2" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id2">[1]</a></td><td>Canyi Lu, Jiashi Feng, Tao Mei, Zhouchen Lin and Shuicheng Yan, Subspace Clustering by Block Diagonal Representation, IEEE Transactions on Pattern Analysis and Machine Intelligence (TPAMI), 2019 </td></tr>
<tr><td class="label"><a class="fn-backref" href="#id2">[2]</a></td><td>Can-Yi Lu, Hai Min, Zhong-Qiu Zhao, Lin Zhu, De-Shuang Huang and Shuicheng Yan, Robust and Efficient Subspace Segmentation via Least Squares Regression. European Conference on Computer Vision (ECCV), pp. 347-360, 2012</td></tr>
</td></tr>
</tbody>
</table>





