


<div class="container-fluid main-container">




<div class="fluid-row" id="header">

<div class="btn-group pull-right">
<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span>Code</span> <span class="caret"></span></button>
<ul class="dropdown-menu" style="min-width: 50px;">
<li><a id="rmd-show-all-code" href="">Show All Code</a></li>
<li><a id="rmd-hide-all-code" href="">Hide All Code</a></li>
<li role="separator" class="divider"></li>
<li><a id="rmd-download-source" href="">Download Rmd</a></li>
</ul>
</div>



<h1 class="title toc-ignore">Machine Learning Model For Financial Fraud Detection</h1>
<h4 class="date">22/07/2020</h4>

</div>

<div id="TOC">
yes
</div>






<p>For this project, I will be applying machine learning techniques to predict the outcome in a given dataset. I will be using a dataset from kaggle that is composed of 6 million of money transactions. Here the goal is to oredict if a given transaction is a Fraud or not.</p>
<hr>
<div id="dataset-overview" class="section level1">
<h1>Dataset Overview</h1>
<div id="context" class="section level2">
<h2>Context</h2>
<p>There is a lack of public available datasets on financial services and specially in the emerging mobile money transactions domain. Financial datasets are important to many researchers and in particular to us performing research in the domain of fraud detection. Part of the problem is the intrinsically private nature of financial transactions, that leads to no publicly available datasets.</p>
<p>This dataset was generated using the simulator called PaySim as an approach to such a problem. PaySim uses aggregated data from the private dataset to generate a synthetic dataset that resembles the normal operation of transactions and injects malicious behaviour to later evaluate the performance of fraud detection methods.</p>
</div>
<div id="content" class="section level2">
<h2>Content</h2>
<p>PaySim simulates mobile money transactions based on a sample of real transactions extracted from one month of financial logs from a mobile money service implemented in an African country. The original logs were provided by a multinational company, who is the provider of the mobile financial service which is currently running in more than 14 countries all around the world.</p>
<hr>
</div>
<div id="headers" class="section level2">
<h2>Headers</h2>
<p>This is a sample of 1 row with headers explanation:</p>





<table>
<colgroup>
<col width="3%">
<col width="6%">
<col width="6%">
<col width="9%">
<col width="11%">
<col width="11%">
<col width="9%">
<col width="11%">
<col width="11%">
<col width="6%">
<col width="11%">
</colgroup>
<thead>
<tr class="header">
<th align="right">step</th>
<th align="left">type</th>
<th align="right">amount</th>
<th align="left">nameOrig</th>
<th align="right">oldbalanceOrg</th>
<th align="right">newbalanceOrig</th>
<th align="left">nameDest</th>
<th align="right">oldbalanceDest</th>
<th align="right">newbalanceDest</th>
<th align="right">isFraud</th>
<th align="right">isFlaggedFraud</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">1</td>
<td align="left">PAYMENT</td>
<td align="right">9839.64</td>
<td align="left">C1231006815</td>
<td align="right">170136</td>
<td align="right">160296.4</td>
<td align="left">M1979787155</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
</tbody>
</table>






<table>
<colgroup>
<col width="15%">
<col width="84%">
</colgroup>
<thead>
<tr class="header">
<th>Column</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>step</td>
<td>maps a unit of time in the real world. In this case 1 step is 1 hour of time. Total steps 744 (30 days simulation)</td>
</tr>
<tr class="even">
<td>type</td>
<td>CASH-IN, CASH-OUT, DEBIT, PAYMENT and TRANSFER.</td>
</tr>
<tr class="odd">
<td>amount</td>
<td>amount of the transaction in local currency.</td>
</tr>
<tr class="even">
<td>nameOrig</td>
<td>customer who started the transaction.</td>
</tr>
<tr class="odd">
<td>oldbalanceOrg</td>
<td>initial balance before the transaction.</td>
</tr>
<tr class="even">
<td>newbalanceOrig</td>
<td>new balance after the transaction.</td>
</tr>
<tr class="odd">
<td>nameDest</td>
<td>customer who is the recipient of the transaction.</td>
</tr>
<tr class="even">
<td>oldbalanceDest</td>
<td>initial balance recipient before the transaction. Note that there is not information for customers that start with M (Merchants).</td>
</tr>
<tr class="odd">
<td>newbalanceDest</td>
<td>new balance recipient after the transaction. Note that there is not information for customers that start with M (Merchants).</td>
</tr>
<tr class="even">
<td>isFraud</td>
<td>This is the transactions made by the fraudulent agents inside the simulation. In this specific dataset the fraudulent behavior of the agents aims to profit by taking control or customers accounts and try to empty the funds by transferring to another account and then cashing out of the system.</td>
</tr>
<tr class="odd">
<td>isFlaggedFraud</td>
<td>The business model aims to control massive transfers from one account to another and flags illegal attempts. An illegal attempt in this dataset is an attempt to transfer more than 200.000 in a single transaction.</td>
</tr>
</tbody>
</table>



<div data-pagedtable="true" pagedtable-page="0" class="pagedtable-wrapper">

<div class="pagedtable pagedtable-not-empty"><table style="visibility: hidden; position: absolute; white-space: nowrap; height: auto; width: auto;"><tr><td>ABCDEFGHIJ0123456789</td></tr></table><table cellspacing="0" class="table table-condensed"><thead><tr><th align="right" style="text-align: right;"><div class="pagedtable-header-name">step</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="left" style="text-align: left;"><div class="pagedtable-header-name">type</div><div class="pagedtable-header-type">&lt;chr&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">amount</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="left" style="text-align: left;"><div class="pagedtable-header-name">nameOrig</div><div class="pagedtable-header-type">&lt;chr&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">oldbalanceOrg</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">newbalanceOrig</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="left" style="text-align: left;"><div class="pagedtable-header-name">nameDest</div><div class="pagedtable-header-type">&lt;chr&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">oldbalanceDest</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">newbalanceDest</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">isFraud</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th style="cursor: pointer; vertical-align: middle; min-width: 5px; width: 5px;"><div style="border-top-color: transparent; border-top-style: solid; border-top-width: 5px; border-bottom-color: transparent; border-bottom-style: solid; border-bottom-width: 5px; border-left-color: initial; border-left-style: solid; border-left-width: 5px;"></div></th></tr></thead><tbody><tr class="odd"><td align="right" style="text-align: right;">1</td><td align="left" style="text-align: left;">PAYMENT</td><td align="right" style="text-align: right;">9839.64</td><td align="left" style="text-align: left;">C1231006815</td><td align="right" style="text-align: right;">170136</td><td align="right" style="text-align: right;">160296.36</td><td align="left" style="text-align: left;">M1979787155</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td></td></tr><tr class="even"><td align="right" style="text-align: right;">1</td><td align="left" style="text-align: left;">PAYMENT</td><td align="right" style="text-align: right;">1864.28</td><td align="left" style="text-align: left;">C1666544295</td><td align="right" style="text-align: right;">21249</td><td align="right" style="text-align: right;">19384.72</td><td align="left" style="text-align: left;">M2044282225</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td></td></tr><tr class="odd"><td align="right" style="text-align: right;">1</td><td align="left" style="text-align: left;">TRANSFER</td><td align="right" style="text-align: right;">181.00</td><td align="left" style="text-align: left;">C1305486145</td><td align="right" style="text-align: right;">181</td><td align="right" style="text-align: right;">0.00</td><td align="left" style="text-align: left;">C553264065</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">1</td><td></td></tr><tr class="even"><td align="right" style="text-align: right;">1</td><td align="left" style="text-align: left;">CASH_OUT</td><td align="right" style="text-align: right;">181.00</td><td align="left" style="text-align: left;">C840083671</td><td align="right" style="text-align: right;">181</td><td align="right" style="text-align: right;">0.00</td><td align="left" style="text-align: left;">C38997010</td><td align="right" style="text-align: right;">21182</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">1</td><td></td></tr><tr class="odd"><td align="right" style="text-align: right;">1</td><td align="left" style="text-align: left;">PAYMENT</td><td align="right" style="text-align: right;">11668.14</td><td align="left" style="text-align: left;">C2048537720</td><td align="right" style="text-align: right;">41554</td><td align="right" style="text-align: right;">29885.86</td><td align="left" style="text-align: left;">M1230701703</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td></td></tr><tr class="even"><td align="right" style="text-align: right;">1</td><td align="left" style="text-align: left;">PAYMENT</td><td align="right" style="text-align: right;">7817.71</td><td align="left" style="text-align: left;">C90045638</td><td align="right" style="text-align: right;">53860</td><td align="right" style="text-align: right;">46042.29</td><td align="left" style="text-align: left;">M573487274</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td></td></tr></tbody></table><div class="pagedtable-footer"><div class="pagedtable-info" title="6 rows | 1-10 of 11 columns">6 rows | 1-10 of 11 columns</div></div></div></div>



<hr>
</div>
</div>
<div id="data-analysis" class="section level1">
<h1>Data Analysis</h1>
<p>Let´s look at our data distribuition when grouped by Fraud or not Fraud transactions.</p>



<pre class="r"><code class="hljs">data %&gt;%
  mutate(isFraud = ifelse(isFraud == <span class="hljs-number">1</span>, <span class="hljs-string">"Fraud"</span>, <span class="hljs-string">"Not Fraud"</span>)) %&gt;%
  ggplot(aes(isFraud, fill = isFraud)) +
  geom_bar() +
  ggtitle(<span class="hljs-string">"Number of Fraud and not Fraud Transactions"</span>) +
  theme_fivethirtyeight() +
  theme(legend.position = <span class="hljs-string">"none"</span>,
        plot.title = element_text(hjust = <span class="hljs-number">0.5</span>))</code></pre>


<p><img src="data:image/png;base64,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"></p>


<pre class="r"><code class="hljs">data %&gt;%
  summarize(Fraud = sum(isFraud == <span class="hljs-number">1</span>), Not_Fraud = sum(isFraud == <span class="hljs-number">0</span>))</code></pre>


<div data-pagedtable="true" pagedtable-page="0" class="pagedtable-wrapper">

<div class="pagedtable pagedtable-not-empty"><table style="visibility: hidden; position: absolute; white-space: nowrap; height: auto; width: auto;"><tr><td>ABCDEFGHIJ0123456789</td></tr></table><table cellspacing="0" class="table table-condensed"><thead><tr><th align="right" style="text-align: right;"><div class="pagedtable-header-name">Fraud</div><div class="pagedtable-header-type">&lt;int&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">Not_Fraud</div><div class="pagedtable-header-type">&lt;int&gt;</div></th><th class="pagedtable-padding-col"></th><th class="pagedtable-padding-col"></th><th class="pagedtable-padding-col"></th></tr></thead><tbody><tr class="odd"><td align="right" style="text-align: right;">8213</td><td align="right" style="text-align: right;">6354407</td><td class="pagedtable-padding-col"></td><td class="pagedtable-padding-col"></td><td class="pagedtable-padding-col"></td></tr></tbody></table><div class="pagedtable-footer"><div class="pagedtable-info" title="1 row">1 row</div></div></div></div>



<p>As we can see there are a lot of transactions that weren´t fraud and just a few that are fraud. This can cause or model to always predict for not fraud and always get a high accuracy. To solve this we will split the data into a set of 50% fraud and 50% not fraud.</p>



<pre class="r"><code class="hljs">
set.seed(<span class="hljs-number">0</span>)
size &lt;- dim(data[data$isFraud == <span class="hljs-number">1</span>,])[<span class="hljs-number">1</span>]
temp_df_fraud &lt;- data[data$isFraud == <span class="hljs-number">1</span>,]
temp_df_not_fraud &lt;- data[data$isFraud == <span class="hljs-number">0</span>,][sample(seq(<span class="hljs-number">1</span>, size), size),]

df &lt;- full_join(temp_df_not_fraud, temp_df_fraud)</code></pre>


<pre><code class="hljs">Joining, by = c("step", "type", "amount", "nameOrig", "oldbalanceOrg", "newbalanceOrig", "nameDest", "oldbalanceDest", "newbalanceDest", "isFraud", "isFlaggedFraud")</code></pre>


<pre class="r"><code class="hljs">rm(temp_df_fraud, temp_df_not_fraud)</code></pre>



<p>As we can see now we have a dataser with equal proportion of fraud and not fraud transactions.</p>



<pre class="r"><code class="hljs">df %&gt;%
  mutate(isFraud = ifelse(isFraud == <span class="hljs-number">1</span>, <span class="hljs-string">"Fraud"</span>, <span class="hljs-string">"Not Fraud"</span>)) %&gt;%
  ggplot(aes(isFraud, fill = isFraud)) +
  geom_bar() +
  ggtitle(<span class="hljs-string">"Number of Fraud and not Fraud Transactions"</span>) +
  theme_fivethirtyeight() +
  theme(legend.position = <span class="hljs-string">"none"</span>,
        plot.title = element_text(hjust = <span class="hljs-number">0.5</span>))</code></pre>


<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAArwAAAGwCAMAAAB8TkaXAAAA21BMVEUAv8Q8PDw8PF48PH48Xl48Xn48Xpw8fn48fpw8frlePDxePF5ePH5eXjxeXl5eXn5efn5efpxefrlenJxenLlenNV+PDx+PF5+PH5+Xjx+Xl5+Xpx+nJx+nLl+nNV+ubl+udV+ufCcXjycXl6cXn6cfl6cfn6cnF6cnLmcudWcufCc1fC5fjy5fl65nF65nH651Zy51bm51dW51fC58NW58PDS0tLVnF7VnH7VuX7VuZzVubnV1bnV1fDV8NXV8PDwuX7w1Zzw1bnw1dXw8Lnw8NXw8PD4dm3////hjTJ+AAAACXBIWXMAAA7DAAAOwwHHb6hkAAAUyklEQVR4nO2dDXvjxnlFDWmtVPLazjqWtm7jxlTjtomYj9rRqnGbiNyQaP//Lyq+SGLA4RXBF68mw3vPoxgSCICDg7MgCGqzn5RCZMonqQcgxKkoXpEtildki+IV2aJ4RbYoXpEtildki+IV2aJ4RbYoXpEtildki+IV2aJ4RbYoXpEtildki+IV2aJ4RbYoXpEtildki+IV2fKq8a7uiuK6+W5RFJePx600YtF9/vx5UVzc9p5+w9XzuA2t74vi9uXFTl5j/Yff7n6YbqBPRY/TNR54qmbM1WAvHqbd8LG8erzFrP7uleJtj10G8f70TeulJY94uzFTxdscjdeJtz6Q17uD//cbbz2y3OLdjJkq3maPXyfeSBOzw0tDXj3eCQdquvA6iGWQE5Eg3lpk53N502rtRMyr/378p6L49MfqeuqmuPiXeqV60T9VPxVf/thu5X+qJS7eNT9UJ5bb/7qpl9/yU/Vo8eVvts93uIndyus/VJfGxZvv6rmDIZXlx++rp/v2r2ETgzWu/lpfXLc/xtfYW6g/0Hl7Zrx2GOjG4CPeUjC2j99Xti863f0Fu4fefPvcG/PuzNtXD7c5FQnird0ejPfn7QvcD/fbq9Vq0YvPm58ummPUvRI2P1TffxG8Hq7ve6+288EL734T3crdgk09wyYWN81Dn34TNDFYo350e3UdXWO4UGygIN6TB1qWg3jjW+qPbXnTPTYb7unmOepB78Ub7BHe5lSkiLfa14PxhnQn6eiPtbEu5K+3z7DbwvUx8bYrL5plntpNDobUv/zcNTFcoz/A+BqDhaIDBfGeOtDNaHfxxrfUG1sV4cV35fr3W927BXfPcb0fb7BHcJuT8erx/qq5XXY43q+fmz/C1StbZ6yu9eI3zZ5XR6V+sLL58ZvGUX0weu/ImmWvqtfE3xXbAxp/H1QHvV153ixV657tDale6Kv2+XpNDNdoDs28AGsMFnqtgW6s9OKNbqk3ti7G3pXcdsGn9kjcN9sbvGEb7BHa5mS8eryzWuDsYLybg7Uztii6a6rm0Wpm81NwRtjSbaC9zXBEE/2Vu4XDIXUbagczfPu1W6N5lnZ6YI1wodcdaBBvfEu9sTVP/ul//GV/TzfvBZdffPuXvbsNgz16eZsT8PrxNufOPx+Ktz4Ai93r76yn/qn+JryIeApvJe3eabcPvNjEZuX1f/9bc1kdbeI23HRsjaYIuMaBhfwHWg7ijW+pN7bN6//Ft8+DBcNRhvEO9whvcyJeP97mBeaLbbyDXYzG2wpfDOKt1hzEu7O7CF7Z9h5u2K68/n6zyb0juV0lbGL8GgcW8h5o7zmO3dLunVc9s78gine4R2ibk5Eg3u6PYT/e3YspOPM2FYf3LMefeSNNNGLf/PI/74IjubsI2D+h7a3x8inwwELOA23ZjxftQNnd16ovj8MFR555D21zOlLE274T7ce7KGC825s2zTVvT+Ag3iMuJSNNdJtchU2EQwovJffWiFz77F/zRq7uvQfash8v3IGGv9V31re6wz9yq/fvfjjimvfQNmNlnEaKeNs7Nl28xT88lz/dvBBveLfh8seNomG8L7+JjzSxe/O4+ZPVG9LmTfxd0Wtib43Y2/5gjeFCrzTQYLhoS72xbZbuv9D17jZ8txn0i3cbDm1zdDYHSRJv84ZkeE8UxdsRu88byNheWrUbOv6EdtveY5rtDSl6+zRc46gbroOFIgOFN6RPHGhL/Mx7aAe6Xwj52JxmDz1ld6lTf9PFO9gjsM3pSBJvU+Dmj2LNm89hvD+72+a6+12T23I/3p3Cd8/lsfH2bq/f7g1pc7e9/pAvuM+7W2P4ChldY7hQONB2gy/Fe8JAy7KMxQt3YPv5Qu/Dv81Tdg/tPpXYxjvYI7TNyUgTb3efu2x+r65403wgD+K9Xv+u2vl33Qfj7Ufom99tGNoY9bsN3Vvv5jcnfti8pgVD6n5l4N2P8+BuQ3+N+C8ZDNbYvwbsD7R5U3/x1Uvxjh9oQ+xuA9qB9tcZ2qENnrL93YavtncsqjGvDv1uw8FtTob+JoXIFsUrskXximxRvCJbFK/IFsUrskXximxRvCJbFK/IFsUrskXximxRvCJbzj/eD6kH8HdM5m4ULzOZu1G8zGTuRvEyk7kbxctM5m4ULzOZu1G8zGTuRvEyk7kbxctM5m4ULzOZu1G8zGTuRvEyk7kbxctM5m4ULzOZu1G8zGTuxj/e/yUH2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWVnT17t/qWN83/wfB4WQ0qeNJDbTPzgk99fVF5q3uZuVT/Y8rX9dfg8loUseTGmifnRN66uuLzFu+fSxX7x+qr/rbcDL+GVLHkxpon53xOQX6IvPW97NycfXcNRxOukU+HE/qeFKD3KRuJznHZ3RsvPXlbf3vbIB4R5A6ntQgN6nbSc74nAJ9kXmru9v6mlfxTgK0z874nAJ9kXnRahXviUD77IzPKdAXmac3bFMC7bMzPqdAX2Te+v5Wt8omA9pn54Se+vpiM7sPKVZ3m3+JsjcZTep4UgPts3NCT319ttWPIHU8qYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaWleL2B9tmxpaV4vYH22bGlpXi9gfbZsaUVXX19XxS3zeTycTgZTep4UgPts3NCT319sZnzq+flZw/l/Lr+GkxGkzqe1ED77JzQU19fZN7q/cNmsnz7GE7GP0PqeFID7bMzPqdAX2Re12g9qZINJ+OfIXU8qYH22RmfU6AvMm9x9fuimMF4PxxP6nhSg9ykbic5x2d0dLzVu7XFxYPOvJOA3KRuJznjcwr0ReYtrp7L9f1M8U4CtM/O+JwCfZF5dadVvHrDNgnQPjvjcwr0xWbOq8uGy0fdKpsEaJ+dE3rq64vNrD+kmJXl6q75WCKcjCZ1PKmB9tk5oae+PtvqR5A6ntRA++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NJSvN5A++zY0lK83kD77NjSUrzeQPvs2NI6sPry7WNZru+Ly73JaFLHkxpon50Teurri8+e153Or+uvwWQ0qeNJDbTPzgk99fVF5y7eVGfe1fuH+gwcTsY/Q+p4UgPtszM+p0BfbOb613+sMl22AYeTbokPx5M6ntQgN6nbSc7xGR0d79Pt8oV4R5A6ntQgN6nbSc74nAJ9kXmrf35WvJMB7bMzPqdAX2TefFYq3smA9tkZn1Ogb3/W6q6omekN2yRA++yMzynQF5/dZKpbZVMA7bNzQk99ffHZTbzVKfhybzKa1PGkBtpn54Se+vpsqx9B6nhSA+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLS/F6A+2zY0tL8XoD7bNjS0vxegPts2NLK7r68qYoZmW5vi8uH4eT0aSOJzXQPjsn9NTXF5m3upuVi4uHcn5dfw0mo0kdT2qgfXZO6KmvLzJvcfVcnWdnq/cP5fLtYzgZ/wyp40kNtM/O+JwCfQfmV2ffOtUq2XDSPfzheFLHkxrkJnU7yTk+ozHxPl09o3hHkDqe1CA3qdtJzvicAn3x2U/VezPFOwnQPjvjcwr0Rec+VW/XFO80QPvsjM8p0Beb+dTcE9MbtkmA9tkZn1OgLzJv+Vl7gtWtsimA9tk5oae+vsi8eVEzK1d3zccS4WQ0qeNJDbTPzgk99fXZVj+C1PGkBtpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHlpbi9QbaZ8eWluL1Btpnx5aW4vUG2mfHltbxq6/vi8vHE54hdTypgfbZOaGnvr6jl5xf11/jSR1PaqB9dk7oqa/v2AVX7x/K5dsTTr2p40kNtM/O+JwCfccuWIdbBzya1PGkBtpnZ3xOgb5jFwzj/SDEqzJhvBkR3W3RkLkbxctM5m7837ClJvMD5ErmbvxvlaUm8wPkSuZujo93dXfahxSpyfwAuZK5G/+Ph1OT+QFyJXM3ipeZzN0oXmYyd6N4mcncjeJlJnM3ipeZzN0oXmYyd6N4mcncjeJlJnM35x+vOFsUr8gWxSuyRfGKbFG8IlsUr8gWxSuyRfGKbFG8IlvOLt7lTVEziz+a5d9/NrG8uS3LyF+dPQdP5xcv/BvOeRyUKVne1H/zcGdl8905eFK8Z87y7b/fKt5M2B6cL7+5fFxUL4zXzaz6f9VPP8vioEzJ8u2fft3ufnWhcPGwuqv+087P39P5xdtcy1VH4mZWru5m5eLioTso9U9PFzkclCmpdnxxvdn9xeXjNtoz8HR+8W4Ozmet/uoFsDsoi6vnTF4Op6Ta8fW/1gq6/7+u4WVDzp7ON956Wp9etmeUp2wOypQ0O/9V1+T6frYXb8aezjre+qyS4xllShof818ePvNm7Oms460u8cp5/Saluoi7zOhabkq6M+vl9pq3u0w4B09nHe/6vii+vq8ORVH84h+bt9u/yOKMMiWtj6rJ9m5D7WS2m5+3p7OLV/CgeEW2KF6RLYpXZIviFdmieEW2KF6RLYpXZIviFdmieEW2KF6RLYpXZIviFdmieEW2KF6RLYpXZIviFdmieEW2KF6RLYpXZIviFdnyyf8JkSn/D4M4bS/wAQjXAAAAAElFTkSuQmCC"></p>



<p>Now we can start constructing the prediction model.</p>
<hr>
</div>
<div id="methods-and-models" class="section level1">
<h1>Methods and Models</h1>
<p><strong>Our goal is to predict wether a certain transaction is a fraud or not, given tha value of the predictors.</strong> First let´s drop all the non-numeric columns, as they don´t apport too much to the data.</p>



<pre class="r"><code class="hljs">df_num &lt;- df %&gt;%
  select(-c(nameOrig, nameDest, type))
head(df_num)</code></pre>


<div data-pagedtable="true" pagedtable-page="0" class="pagedtable-wrapper">

<div class="pagedtable pagedtable-not-empty"><table style="visibility: hidden; position: absolute; white-space: nowrap; height: auto; width: auto;"><tr><td>ABCDEFGHIJ0123456789</td></tr></table><table cellspacing="0" class="table table-condensed"><thead><tr><th align="right" style="text-align: right;"><div class="pagedtable-header-name">step</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">amount</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">oldbalanceOrg</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">newbalanceOrig</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">oldbalanceDest</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">newbalanceDest</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">isFraud</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th><th align="right" style="text-align: right;"><div class="pagedtable-header-name">isFlaggedFraud</div><div class="pagedtable-header-type">&lt;dbl&gt;</div></th></tr></thead><tbody><tr class="odd"><td align="right" style="text-align: right;">7</td><td align="right" style="text-align: right;">1041.96</td><td align="right" style="text-align: right;">70789.0</td><td align="right" style="text-align: right;">69747.04</td><td align="right" style="text-align: right;">0.0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td></tr><tr class="even"><td align="right" style="text-align: right;">1</td><td align="right" style="text-align: right;">107440.87</td><td align="right" style="text-align: right;">140757.4</td><td align="right" style="text-align: right;">33316.54</td><td align="right" style="text-align: right;">266398.1</td><td align="right" style="text-align: right;">373839</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td></tr><tr class="odd"><td align="right" style="text-align: right;">2</td><td align="right" style="text-align: right;">48183.10</td><td align="right" style="text-align: right;">120039.9</td><td align="right" style="text-align: right;">71856.76</td><td align="right" style="text-align: right;">1412484.1</td><td align="right" style="text-align: right;">1791002</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td></tr><tr class="even"><td align="right" style="text-align: right;">4</td><td align="right" style="text-align: right;">248011.57</td><td align="right" style="text-align: right;">0.0</td><td align="right" style="text-align: right;">0.00</td><td align="right" style="text-align: right;">9941904.2</td><td align="right" style="text-align: right;">12362817</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td></tr><tr class="odd"><td align="right" style="text-align: right;">7</td><td align="right" style="text-align: right;">6356.01</td><td align="right" style="text-align: right;">10787.0</td><td align="right" style="text-align: right;">4430.99</td><td align="right" style="text-align: right;">0.0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td></tr><tr class="even"><td align="right" style="text-align: right;">1</td><td align="right" style="text-align: right;">12429.59</td><td align="right" style="text-align: right;">16231.0</td><td align="right" style="text-align: right;">3801.41</td><td align="right" style="text-align: right;">0.0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td><td align="right" style="text-align: right;">0</td></tr></tbody></table><div class="pagedtable-footer"><div class="pagedtable-info" title="6 rows">6 rows</div></div></div></div>



<p>Now let´s create the training and testing datasets (which are mutal exclusive). This will make our model don´t be overfitted to the trainig data and will make our predictions more accurate to the ones of the real values for any given dataset.</p>



<pre class="r"><code class="hljs">set.seed(<span class="hljs-number">0</span>)
test_index &lt;- createDataPartition(df_num$isFraud, times = <span class="hljs-number">1</span>, p = <span class="hljs-number">0.2</span>, list = <span class="hljs-literal">FALSE</span>) <span class="hljs-comment"># first create the indexes for the test set
</span>

<span class="hljs-comment"># select our test set
</span>
test_x &lt;- select(df_num, -isFraud)[test_index,]
test_y &lt;- df_num$isFraud[test_index]

<span class="hljs-comment"># select the reamining indexes for our train set
</span>
train_x &lt;- select(df_num, -isFraud)[-test_index,]
train_y &lt;- df_num$isFraud[-test_index]

<span class="hljs-comment"># change de training data as factor because we will only have to values
</span>
train_y &lt;- as.factor(train_y)</code></pre>



<p>Now, with our train and test data set. We can train a machine learning model that predicts wether a transactions is a Fraud or not given the numeric predictors.</p>
<hr>
<div id="model-1-k-means" class="section level3">
<h3>Model 1: K Means</h3>
<p>Is a grouping method, which aims at dividing a set of n observations into k groups in which each observation belongs to the group whose mean value is closest.</p>



<pre class="r"><code class="hljs">predict_kmeans &lt;- <span class="hljs-keyword">function</span>(x, k) {
    centers &lt;- k$centers    <span class="hljs-comment"># extract cluster centers
</span>
    <span class="hljs-comment"># calculate distance to cluster centers
</span>
    distances &lt;- sapply(<span class="hljs-number">1</span>:nrow(x), <span class="hljs-keyword">function</span>(i){
                        apply(centers, <span class="hljs-number">1</span>, <span class="hljs-keyword">function</span>(y) dist(rbind(x[i,], y)))
                 })
  max.col(-t(distances))  <span class="hljs-comment"># select cluster with min distance to center
</span>
}
set.seed(<span class="hljs-number">0</span>)
k &lt;- kmeans(train_x, centers = <span class="hljs-number">2</span>)
kmeans_preds &lt;- ifelse(predict_kmeans(test_x, k) == <span class="hljs-number">1</span>, <span class="hljs-number">0</span>, <span class="hljs-number">1</span>)
<span class="hljs-comment"># mean(kmeans_preds == test_y)</span></code></pre>



<p>Results</p>



<pre class="r"><code class="hljs">results &lt;- data_frame(method = <span class="hljs-string">"K means"</span>, accuracy = mean(kmeans_preds == test_y)) <span class="hljs-comment"># save the results in the data frame
</span>
results %&gt;% knitr::kable()</code></pre>




<table>
<thead>
<tr class="header">
<th align="left">method</th>
<th align="right">accuracy</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">K means</td>
<td align="right">0.5003043</td>
</tr>
</tbody>
</table>






<hr>
</div>
<div id="model-2-glm" class="section level3">
<h3>Model 2: GLM</h3>
<p>GLM will keep the weighted sum of all the features, but allow non-Gaussian outcome distributions (not like a linear regression model) and connect the expected mean of this distribution and the weighted sum through a possibly nonlinear function.</p>



<pre class="r"><code class="hljs">set.seed(<span class="hljs-number">0</span>)
<span class="hljs-comment"># Train the model
</span>
train_glm &lt;- train(train_x, train_y,
                     method = <span class="hljs-string">"glm"</span>)

<span class="hljs-comment"># Predict for the test set
</span>
glm_preds &lt;- predict(train_glm, test_x)
<span class="hljs-comment"># mean(glm_preds == test_y)</span></code></pre>



<p>Results</p>



<pre class="r"><code class="hljs">results &lt;- bind_rows(results, <span class="hljs-comment"># add accuracy to the df
</span>
                          data_frame(method=<span class="hljs-string">"Logistic regression"</span>,
                                     accuracy = mean(glm_preds == test_y)))
results %&gt;% knitr::kable()</code></pre>




<table>
<thead>
<tr class="header">
<th align="left">method</th>
<th align="right">accuracy</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">K means</td>
<td align="right">0.5103469</td>
</tr>
<tr class="even">
<td align="left">Logistic regression</td>
<td align="right">0.9923920</td>
</tr>
</tbody>
</table>






<hr>
</div>
<div id="model-3-lda" class="section level3">
<h3>Model 3: LDA</h3>
<p>Linear Discriminant Analysis (LDA) is a method used to find a linear combination of features that characterize or separate two or more kinds of objects or events. The resulting combination can be used as a linear classifier.</p>



<pre class="r"><code class="hljs">set.seed(<span class="hljs-number">0</span>)
<span class="hljs-comment"># Train the model
</span>
train_lda &lt;- train(train_x, train_y,
                     method = <span class="hljs-string">"lda"</span>)

<span class="hljs-comment"># Predict for the test set
</span>
lda_preds &lt;- predict(train_lda, test_x)
<span class="hljs-comment"># mean(lda_preds == test_y)</span></code></pre>



<p>Results</p>



<pre class="r"><code class="hljs">results &lt;- bind_rows(results, <span class="hljs-comment"># add accuracy to the df
</span>
                          data_frame(method=<span class="hljs-string">"LDA"</span>,
                                     accuracy = mean(lda_preds == test_y)))
results %&gt;% knitr::kable()</code></pre>




<table>
<thead>
<tr class="header">
<th align="left">method</th>
<th align="right">accuracy</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">K means</td>
<td align="right">0.4952055</td>
</tr>
<tr class="even">
<td align="left">Logistic regression</td>
<td align="right">0.9933049</td>
</tr>
<tr class="odd">
<td align="left">LDA</td>
<td align="right">0.8889227</td>
</tr>
</tbody>
</table>






<hr>
</div>
<div id="model-4-knn" class="section level3">
<h3>Model 4: KNN</h3>
<p>It is a method that simply searches the closest observations to the one you are trying to predict and classifies the point of interest based on most of the data that surrounds it.</p>



<pre class="r"><code class="hljs">set.seed(<span class="hljs-number">0</span>)
<span class="hljs-comment"># Train the model
</span>
train_knn &lt;- train(train_x, train_y,
                     method = <span class="hljs-string">"knn"</span>,
                     tuneGrid = data.frame(k = seq(<span class="hljs-number">1.95</span>, <span class="hljs-number">2</span>, <span class="hljs-number">0.01</span>)))
<span class="hljs-comment"># Predict for the test set
</span>
knn_preds &lt;- predict(train_knn, test_x)
<span class="hljs-comment"># mean(knn_preds == test_y)
</span>
<span class="hljs-comment"># train_knn$bestTune %&gt;% pull()</span></code></pre>



<p>Results</p>



<pre class="r"><code class="hljs">results &lt;- bind_rows(results, <span class="hljs-comment"># add accuracy to the df
</span>
                          data_frame(method=<span class="hljs-string">"KNN"</span>,
                                     accuracy = mean(knn_preds == test_y),
                                     tune = train_knn$bestTune %&gt;% pull()))
results %&gt;% knitr::kable()</code></pre>




<table>
<thead>
<tr class="header">
<th align="left">method</th>
<th align="right">accuracy</th>
<th align="right">tune</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">K means</td>
<td align="right">0.4952055</td>
<td align="right">NA</td>
</tr>
<tr class="even">
<td align="left">Logistic regression</td>
<td align="right">0.9933049</td>
<td align="right">NA</td>
</tr>
<tr class="odd">
<td align="left">LDA</td>
<td align="right">0.8889227</td>
<td align="right">NA</td>
</tr>
<tr class="even">
<td align="left">KNN</td>
<td align="right">0.9793061</td>
<td align="right">1.99</td>
</tr>
</tbody>
</table>






<p>The best accuracy is given a k of 1.99, as it is ilustrated in the next plot.</p>



<pre class="r"><code class="hljs">train_knn$results %&gt;%
  ggplot(aes(x = k, y = Accuracy)) +
  geom_line(color = <span class="hljs-string">"blue"</span>) +
  ggtitle(<span class="hljs-string">"Accuracy of the knn model"</span>) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = <span class="hljs-number">0.5</span>))</code></pre>


<p><img src="data:image/png;base64,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"></p>



<hr>
</div>
<div id="model-5-random-forest" class="section level3">
<h3>Model 5: Random Forest</h3>
<p>The random forest is a classification algorithm consisting of many decisions trees. It uses bagging and feature randomness when building each individual tree to try to create an uncorrelated forest of trees whose prediction by committee is more accurate than that of any individual tree.</p>



<pre class="r"><code class="hljs">set.seed(<span class="hljs-number">0</span>)
<span class="hljs-comment"># Train the model
</span>
train_rf &lt;- train(train_x, train_y,
                  method = <span class="hljs-string">"rf"</span>,
                  tuneGrid = data.frame(mtry = seq(<span class="hljs-number">5.4</span>,<span class="hljs-number">5.6</span>,<span class="hljs-number">0.1</span>)),
                  importance = <span class="hljs-literal">TRUE</span>)
<span class="hljs-comment"># Predict for the test set
</span>
rf_preds &lt;- predict(train_rf, test_x)
<span class="hljs-comment"># mean(rf_preds == test_y)
</span>
<span class="hljs-comment"># train_rf$bestTune %&gt;% pull()</span></code></pre>



<p>Results</p>



<pre class="r"><code class="hljs">results &lt;- bind_rows(results, <span class="hljs-comment"># add accuracy to the df
</span>
                          data_frame(method=<span class="hljs-string">"RF"</span>,
                                     accuracy = mean(rf_preds == test_y),
                                     tune = train_rf$bestTune %&gt;% pull()))
results %&gt;% knitr::kable()</code></pre>




<table>
<thead>
<tr class="header">
<th align="left">method</th>
<th align="right">accuracy</th>
<th align="right">tune</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">K means</td>
<td align="right">0.4952055</td>
<td align="right">NA</td>
</tr>
<tr class="even">
<td align="left">Logistic regression</td>
<td align="right">0.9933049</td>
<td align="right">NA</td>
</tr>
<tr class="odd">
<td align="left">LDA</td>
<td align="right">0.8889227</td>
<td align="right">NA</td>
</tr>
<tr class="even">
<td align="left">KNN</td>
<td align="right">0.9793061</td>
<td align="right">1.99</td>
</tr>
<tr class="odd">
<td align="left">RF</td>
<td align="right">0.9975654</td>
<td align="right">5.50</td>
</tr>
</tbody>
</table>






<p>The best accuracy is given a mtry value of 5.5, as it is ilustrated in the next plot.</p>



<pre class="r"><code class="hljs">train_rf$results %&gt;%
  ggplot(aes(x = mtry, y = Accuracy)) +
  geom_smooth() +
  ggtitle(<span class="hljs-string">"Accuracy of the RF model"</span>) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = <span class="hljs-number">0.5</span>))</code></pre>



<hr>
</div>
<div id="model-6-ensemble" class="section level3">
<h3>Model 6: Ensemble</h3>
<p>We have created a few machine learning models with different accuracy values. But may be we can improve this further by combining all of this models into one.</p>
<p>For this we will use all of the models prediction and use a mayority vote to decide wich vale is the correct one. By doing this we can expect a better accuracy than the average model accuracy.</p>



<pre class="r"><code class="hljs"><span class="hljs-comment">#kmeans_preds_num &lt;- ifelse(kmeans_preds == "B", 1, 2)</span></code></pre>


<pre><code class="hljs">Warning messages:
1: In readChar(file, size, TRUE) : truncating string with embedded nuls
2: In readChar(file, size, TRUE) : truncating string with embedded nuls
3: In readChar(file, size, TRUE) : truncating string with embedded nuls
4: In readChar(file, size, TRUE) : truncating string with embedded nuls
5: In readChar(file, size, TRUE) : truncating string with embedded nuls</code></pre>


<pre class="r"><code class="hljs">models &lt;- matrix(c(kmeans_preds, glm_preds, lda_preds, knn_preds, rf_preds), ncol = <span class="hljs-number">5</span>)

ensemble_preds &lt;- ifelse(rowMedians(models) == <span class="hljs-number">1</span>, <span class="hljs-number">0</span>, <span class="hljs-number">1</span>)

models &lt;- c(<span class="hljs-string">"K means"</span>, <span class="hljs-string">"Logistic regression"</span>, <span class="hljs-string">"LDA"</span>, <span class="hljs-string">"K nearest neighbors"</span>, <span class="hljs-string">"Random forest"</span>, <span class="hljs-string">"Ensemble"</span>)
accuracy &lt;- c(mean(kmeans_preds == test_y),
              mean(glm_preds == test_y),
              mean(lda_preds == test_y),
              mean(knn_preds == test_y),
              mean(rf_preds == test_y),
              mean(ensemble_preds == test_y))
data.frame(Model = models, Accuracy = accuracy) %&gt;% knitr::kable()</code></pre>




<table>
<thead>
<tr class="header">
<th align="left">Model</th>
<th align="right">Accuracy</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">K means</td>
<td align="right">0.5003043</td>
</tr>
<tr class="even">
<td align="left">Logistic regression</td>
<td align="right">0.9933049</td>
</tr>
<tr class="odd">
<td align="left">LDA</td>
<td align="right">0.8889227</td>
</tr>
<tr class="even">
<td align="left">K nearest neighbors</td>
<td align="right">0.9793061</td>
</tr>
<tr class="odd">
<td align="left">Random forest</td>
<td align="right">0.9975654</td>
</tr>
<tr class="even">
<td align="left">Ensemble</td>
<td align="right">0.9908704</td>
</tr>
</tbody>
</table>






<p>The ensemble model got a very good accuracy, however it´s still behind the Logistic Regression and Random Forest models, as seen in the next plot.</p>



<pre class="r"><code class="hljs">data.frame(Model = models, Accuracy = accuracy) %&gt;%
  ggplot(aes(x = Model, y = Accuracy, size = <span class="hljs-number">8</span> , color = Model, alpha = <span class="hljs-number">0.5</span>)) +
  geom_point() +
  theme_fivethirtyeight() +
  ggtitle(<span class="hljs-string">"Model comparison"</span>) +
  theme(legend.position = <span class="hljs-string">"none"</span>,
        plot.title = element_text(hjust = <span class="hljs-number">0.5</span>)) +
  scale_y_continuous(trans = <span class="hljs-string">"logit"</span>)</code></pre>


<p><img src="data:image/png;base64,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"></p>



<p>We could improve it a little bit by just using the models with an accuracy above 90%.</p>



<pre class="r"><code class="hljs"><span class="hljs-comment">#kmeans_preds_num &lt;- ifelse(kmeans_preds == "B", 1, 2)
</span>
models &lt;- matrix(c(glm_preds, knn_preds, rf_preds), ncol = <span class="hljs-number">3</span>)

ensemble_preds &lt;- ifelse(rowMedians(models) == <span class="hljs-number">1</span>, <span class="hljs-number">0</span>, <span class="hljs-number">1</span>)

models &lt;- c(<span class="hljs-string">"Logistic regression"</span>, <span class="hljs-string">"K nearest neighbors"</span>, <span class="hljs-string">"Random forest"</span>, <span class="hljs-string">"Ensemble"</span>)
accuracy &lt;- c(mean(glm_preds == test_y),
              mean(knn_preds == test_y),
              mean(rf_preds == test_y),
              mean(ensemble_preds == test_y))
data.frame(Model = models, Accuracy = accuracy) %&gt;% knitr::kable()</code></pre>

<p>


<table>
<thead>
<tr class="header">
<th align="left">Model</th>
<th align="right">Accuracy</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Logistic regression</td>
<td align="right">0.9905660</td>
</tr>
<tr class="even">
<td align="left">K nearest neighbors</td>
<td align="right">0.9793061</td>
</tr>
<tr class="odd">
<td align="left">Random forest</td>
<td align="right">0.9975654</td>
</tr>
<tr class="even">
<td align="left">Ensemble</td>
<td align="right">0.9960438</td>
</tr>
</tbody>
</table>



 </p>
<pre class="r"><code class="hljs">results &lt;- bind_rows(results, <span class="hljs-comment"># add accuracy to the df
</span>
                          data_frame(method=<span class="hljs-string">"Ensemble"</span>,
                                     accuracy = mean(ensemble_preds == test_y)))</code></pre>



<p>Now the Ensemble model improve a lot, with an Accuracy of 0.996. However it´s still second to the accuracy of the Random Forest model, as seen in the next plot.</p>



<pre class="r"><code class="hljs">data.frame(Model = models, Accuracy = accuracy) %&gt;%
  ggplot(aes(x = Model, y = Accuracy, size = <span class="hljs-number">8</span> , color = Model, alpha = <span class="hljs-number">0.5</span>)) +
  geom_point() +
  theme_fivethirtyeight() +
  ggtitle(<span class="hljs-string">"Model comparison"</span>) +
  theme(legend.position = <span class="hljs-string">"none"</span>,
        plot.title = element_text(hjust = <span class="hljs-number">0.5</span>)) +
  scale_y_continuous(trans = <span class="hljs-string">"logit"</span>)</code></pre>


<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAArwAAAGwCAMAAAB8TkaXAAABBVBMVEUrw8cxyc08PDw8PF48PH48Xl48Xn48Xpw8fn48fpw8frlePDxePF5ePH5eXjxeXl5eXn5eXpxefn5efpxefrlenJxenLlenNVfyMps1dh+PDx+PF5+PH5+Xjx+Xl5+fl5+fn5+nJx+nLl+nNV+ubl+udV+ufCOtSuTvDGcXjycXl6cfl6cfn6cnF6cnLmcudWc1fCjvl+wzGy5fjy5fl65nF65nH65uX651bm51dW51fC58NW58PDJjvbMo+vPk/zS0tLVnF7VnH7VuX7VuZzVubnV1bnV1fDV8NXV8PDZsPjnn5vwiILwuX7w1Zzw1bnw1dXw8Lnw8NXw8PD0raj2j4j///8WnKD2AAAACXBIWXMAAA7DAAAOwwHHb6hkAAAUkUlEQVR4nO2dDXvb5nlGY0qpWsp207q1arlZ12xhrKYfqtV2i6fNYbutlTcyo2Dv//+U4v0AAZIPzVuSqQfwe86VGJRIvjgCjkB86CI/qQAGyifeAgC3hXhhsBAvDBbihcFCvDBYiBcGC/HCYCFeGCzEC4OFeGGwEC8MFuKFwUK8MFiIFwYL8cJgIV4YLMQLg4V4YbAQLwwW4oXBQryJ2SgwibcXp+H2ydbHXp9t3ls/5+B8j373NY9BQbyJFO/Jxm0L4u0JxJtIwR5dhdsXxDsMiDeR4o1thDZ7GS+sQbyJEO+Pj2OT8+ODXyzj/c9/qG9+9rv8qO++rgP/4m9NvP9d33nw5FW4uR7vd18fj0affnFVbYxSb9cn39Vff+9Vdf2n49HBP+XZH/3tD/VT0mj1PY/rZ3z6Zbg9ref25+P68c084tgHn72qNgefH9fj/OVx89SPHOJNhHh/ehr3G6ajw9/kePNGuNmfmB3HL773ebp3mu47CId5a/HmR6bnrY5Sx/vj+NXhN+0mvp79p8ftaHnPZTQap9n8MDz8Ms9jnsdOh5erg9f3Bbv3v3J8NBBvIsR7chHiqGs4+mNe+U1DqaJ0FmKZxqy5HYpajbd95HhjlParzOFlZ6zll3WL0zR0/h15mudR+x18WV3/MT1ybfBl2PnejxviTYR6JuEFOiRyMmvzPKpf3f+QNnOhop9cVd99Hu8Nm7yj9NV4Pd6Q3e/iI+qE1kYJtT29ihvMes8hBxoeE56Rf2su4iNDiXm247BZTfPIcwq/H5MNxfCUkPZFs2H+qCHeRIw37DFe1bcms2VDy9f9cf63SoWchH9jrmkruRJvc0Q3/+EXf10fpflyOuoGOmtiax4cyH3mvjvx1tn/9q/pMWuD5+GW048b4k3EeuouDi8v6v9ny21r2nOchkSWX6Ybq6/0K/Hm6hJro4TcxmmG4YW93YCml/nmxvV//frxaLnBTz3neeQdhYNwNLg+ePMbtWLw0UK8ibTpq7v459O09U07ELmAWT5eao+RVuJtX8wTK+msjSLFe/11M7QR7/IQLW+Gu4MTb4nMYgvTeNCfwhS2vJ1jog+65Y15fvrLfz01483nykbNrszaljeOQ7wlkeJNB+uTvFdr7K2u7vN2+jD3eRfPn3yzbZSNeDv7vHnoxbZ4a/7vT8fNr8LaPi/xFsds+SqcX33fc7bhdLldPnzVVLN5tuHL5nmbZxvsePMJsHaj3p5t6MbbbKTTgeLm2QbiLY4UbzwYSq++Id7l3uXtz/PWg62NsjXe9ugvzT6ektuMN/621L9CZ5Yi8ZbIrD3fetLsGHTSeBLryZcADh6vXGFLewj2FbbuH0vkUbbu8/6ifUZ75eFkc7dheSFi9fLdk3yFjXiLY/WVOqz7rX/b8OTVRb433fmev234if23DVsO2P6y/NuG8EcPo8++WV5oW93nTX/4sJRa+9sG4oX7ZVbE5dwPDfH2AuK9DcTbC4j3NhBvLyDe20C8vYB4bwPxwmAhXhgsxAuDhXhhsBAvDBbihcFCvDBY+hjvt94CBjhp3KsT8WrgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTwJvXr//99Zv7mx/xauC0m9dv3rz5jzdvXt/bDIlXA6edhHZDvPdXL/Fq4LSL2G6M997qJV4NnHbw5g3xBnq1UjI47eB1J977qpd4NXDaAfEmerVSMjjtgHgTvVopGZx2QLyJXq2UDE474IAt0auVksFpF5wqi/RrpSRw2gkXKQI9WykRnHbD5eGqfyslgJMAf5jTw5VS4aTCn0R6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4aZcf79t27/3331ttig+JDESk63ndv3779n7dv33l7rFN8KCIlxxvaDfH2rt7iQxEpON7Yboy3b/UWH4pIufG+fUu8N6B4p17F+64Tb8/qLT4UEeIlXoninYhXo/hQRIiXeCWKd+pVvByw3YjinXoVL6fKbkTxTv2Kl4sUN6F4p57Fy+XhG1C8U9/i5Q9zdIp36l28FStFpXgn4tXASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0/OO9PhsdXqab8+PR0VV3Eqf7pfiVIlK8kxnvxTj8F1icnlTTcTOpZuP7cCp+pYgU72TFu3h+Xs0fxU1vmNRf5kl1cXIfTsWvFJHinax4m1Sr9Xivf3Xeedi3APfGLeJdnE6q6WjSTJ4/Hh2cG8/4sBS/RREp3mlHvOEQ7enZJE/mD8+rxc8v9+1U/EoRKd5pV7xVtdwIr0z2SfErRaR4px0HbIHOsVtFvD2ieKddp8rCKYZxM5kdXlbzH3GetycU72TGuziNFynCibFZuiqRJ9PR8urFHil+pYgU78TlYQ2cNIjXW8AAJw3i9RYwwEmDeL0FDHDSIF5vAQOcNIjXW8AAJw3i9RYwwEmDeL0FDHDSIF5vAQOcNIjXW8AAJw3i9RYwwEmDeL0FDHDSIF5vAQOcNIjXW8AAJw3i9RYwwEmDeL0FDHDSIF5vAQOcNIjXW8AAJw3i9RYwwEmDeL0FDHDSIF5vAQOcNIjXW8AAJw3i9RYwwEmDeL0FDHDSIF5vAQOcNIjXW8AAJw3i9RYwwEmDeL0FDHDSIF5vAYPeOT178OCTB8+8LTYgXm8Bg745PXj27NnPnj174O2xDvF6Cxj0zCm0G+LtXb3E6y1g0C+n2G6Mt2/1Eq+3gEGvnJ49I94A8Wr0yulBJ96e1Uu83gIGvXIi3gTxavTKiXgTxKvRKyfiTRCvRq+cOGBLEK9Gv5w4VRYhXo2eOXGRIkC8Gn1z4vJwRbwqvXPiD3OIVwUnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0/OO9PhsdXqab8+PR0dVy0rljjxS/UkSKdzLjvRiH/wKL05NqOm4mnTv2SfErRaR4JyvexfPzav4obmHDpP4yTzp37JPiV4pI8U5WvDnVzs3VSX7YtwD3xi3iXZxOqulokier8e6N4rcoIsU77Yg3HKk9PZvkCfH2iuKddsVbVcuN8Ppuw94ofqWIFO+044At0B67ccDWK4p32nWqrM61vpknnCrrFcU7mfEuTuO1iIuTqpqN4tWJPMl37JniV4pI8U5cHtbASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDASYN4vQUMcNIgXm8BA5w0iNdbwAAnDeL1FjDAScM/3uuz0eFlujk/Hh1dxcnBeZzEL/dL8StFpHgnM96LcfgvsDg9qabjejKppnXPs/F9OBW/UkSKd7LiXTw/r+aP4qY3TOov86S6OLkPp+JXikjxTla8TartzeuzSTU7urr+1XnnYd8C3Bu3iDfuL4wmYS+43tddPH8cd333TPFbFJHinXbEGw7Rnp5N4q7v4eX84Xm1+Pnlvp2KXykixTvtirequvu86at9OxW/UkSKd9pxwBaobxIvThru8XZPlYVTDON6lzfuNswOL6v5jzjP2xOKdzLjXZzGixThxNhs1L1IMR0tr17skeJXikjxTlwe1sBJg3i9BQxw0iBebwEDnDSI11vAACcN4vUWMMBJg3i9BQxw0iBebwEDnDSI11vAACcN4vUWMMBJg3i9BQxw0iBebwEDnDSI11vAACcN4vUWMMBJg3i9BQxw0iBebwEDnDSI11vAACcN4vUWMMBJg3i9BQxw0iBebwEDnDSI11vAACcN4vUWMMBJg3i9BQxw0iBebwEDnDSI11vAACcN4vUWMMBJg3i9BQxw0iBebwEDnDSI11vAACcN4vUWMMBJg3i9BQxw0iBebwEDnDSI11vAACcN/3i3fgJm5449UvxKESneyYx36ydgtnfsk+JXikjxTla8Wz8Bc+2TVvZF71bKyxcvvnrx0ttig94tp6oH8W79BMy1z7jaF31bKS9evnz5+5cvX3h7rNO35RToU7yrn4C5Gq/3B3reF1/9PvOVt0nJ3CLetU/ALHHLG7a7ccvbu21vv5ZTok9b3kC7z1tivC9fEu8NcI936ydglnjA9qITb8/q7dVyyrjHu/UTMEs8VUa8N8I/3q2fgJnv2DO9WinEeyP843WmVyuFeG8E8XoLdOGA7UYQr7fACpwquwnE6y2wyosm3p6127flFCFeb4E1uDysQ7zeAuvwhzkyxOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axOstYICTBvF6CxjgpEG83gIGOGkQr7eAAU4axccLIEG8MFiIFwYL8cJgIV4YLMQLg4V4YbAQLwwW4oXB4hTv/HgU2P0mEOH9KavqQ71PTxpmfjz5QCN1bmXROw629Zu3XgAfZMml1WWure1v/3UR3/Fjn3jFqy7SPcQ7f3ijd1vbNet9xasb7J9kcGHFuDXe972p3Qf6icqL96bvFEi8y1csy2Pr4nyf9UcS7/zRb0aj9LZS7ftJXZ/98ng0rl+rwruk/WO4P1Z39/eaqocJ7zi8Ous8bm1Qz2/+2eeHl+13Ds7r2wfnmw8PQrXgD84m80f/MorvYBxF8xtjxWHyz6QvjfymWs24lx2DPL9Rku9a5kevezeT/MR4K/0At1tu+d+8lNq19v3w5otx/M5aSz/LaNJZGOYyvSO++7z1Yjg+qWb1j1YvgtnRVdh8TcPk6GpxenRVv8Cnm2FN5vvuNttH/3a2fKPAPOs8boh6VkdyPKma7ySntqzuw/OvwTSsoHH6fhwjDnN4GYbJz5e04izyc5txH112DPL8mk9b6Fg2Fuve7ZOXTvEHuN1yi7sN6cNJ4lI6WZqGFiftEohrLT+nszDsZXpH3Le8D88728POpwjk/+Or8cW4fZvVu8324eMfnJ0svzivVscNb0Gcvhnf0PV0ZY9l9eH1JIQZfq/S91vRZph2Gy8ujfzcZtyVpZLnt6reffSGd/vkjtMtq0nbmrzg2qHivJdv29xZa/aMN5fpHXGPN62Y8GJcvyTGhXSwEe80xpvuu9ts623A8ngtz7oZN0zbl+fwnezUxLvy8PpWeBm4Ti/vTbzT8az9Zn6+vjTyczvjtgZ5fp0nZJGuxYp3++TZiuitllscfVJV3aWUjPLvT15Vq/HOtrl9ZPHWzNLnBlRVtbHlPcm/xh9kttPD1RrzZi9sK5+fr63h1mn94e2WtxNvFG2Gyc/Xl8bGlrdjsLbl7Sy1FYuOd/vkjtMd4g27C2tLSd3ybl2md6Qn8YaFkncocwjLeOs9pONmn/euP3R8/nXe7e1UF1ZEeO/stE3J38lOzZZ69eGdfd7m+1G02c0L30zP15fGxj5vxyDPr92fbCw7FpveyaTrdId4w6myzlJq5t3Z512PtzNje5neEd8DtuWq75xtiMetnXi7ZxvueoyaVkI4xKpW9ljiPEfho2Oa1/v2cL2+Y7L58PxS+P3ldmXtbMOj9qhfXRonnbMNedzWoHnpnbQ/R7ZsH73qbZxtuGO8i9NxZynlgX/aOduwHm93YZjL9I5wefhO7OvjZW427j18yE0vId5bo+8W7HPcfVkMAeK9PdM7n/34EOPuy2IAEC8MFuKFwUK8MFiIFwYL8cJgIV4YLMQLg4V4YbAQLwwW4oXBQrwwWIgXBgvxwmAhXhgsxAuDhXhhsBAvDBbihcHyyf8DDJS/AwtaGDRcaaj7AAAAAElFTkSuQmCC"></p>



<p>The best model is the Random Forest with an accuracy of 0.9975654, that´s pretty high!</p>
<hr>
</div>
</div>
<div id="results" class="section level1">
<h1>Results</h1>
<p>At the end we got 6 different models, included one that combined the best models in the list. The highest accuracy model was the one created with the Random Forest method and the one that had the lowest accuracy was the one created with the K Means method.</p>



<pre class="r"><code class="hljs">results %&gt;% knitr::kable()</code></pre>




<table>
<thead>
<tr class="header">
<th align="left">method</th>
<th align="right">accuracy</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">K means</td>
<td align="right">0.5003043</td>
</tr>
<tr class="even">
<td align="left">Ensemble</td>
<td align="right">0.9960438</td>
</tr>
<tr class="odd">
<td align="left">Ensemble</td>
<td align="right">0.9960438</td>
</tr>
</tbody>
</table>






<p>The models accuracy can be better comprehended with the next plot.</p>



<pre class="r"><code class="hljs">results %&gt;%
  ggplot(aes(x = method, y = accuracy, size = <span class="hljs-number">8</span> , color = method, alpha = <span class="hljs-number">0.5</span>)) +
  geom_point() +
  theme_fivethirtyeight() +
  ggtitle(<span class="hljs-string">"Model comparison"</span>) +
  theme(legend.position = <span class="hljs-string">"none"</span>,
        plot.title = element_text(hjust = <span class="hljs-number">0.5</span>)) +
  scale_y_continuous(trans = <span class="hljs-string">"logit"</span>)</code></pre>


<p><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAArwAAAGwCAMAAAB8TkaXAAAA51BMVEUrw8cxyc08PDw8PF48PH48Xl48Xn48Xpw8fpw8frlePDxePF5ePH5eXjxeXl5eXn5eXpxefn5efpxefrlenJxenLlenNVfyMps1dh+PDx+PF5+PH5+Xjx+Xl5+fl5+fn5+nJx+nLl+nNV+ubl+udV+ufCcXjycXl6cfl6cfn6cnF6cnLmcudWc1fC5fjy5fl65nF65nH651bm51dW51fC58NW58PDS0tLVnF7VnH7VuX7VuZzVubnV1bnV1fDV8NXV8PDwiILwuX7w1Zzw1bnw1dXw8Lnw8NXw8PD2enH2j4j4e3L///+eMTnIAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAO8UlEQVR4nO2dD3vb5AEHW6clS6AwyhqSjjHYSMYYDTC64rENMqdLvHTf//NMryT/jRObtK59+t090NiPHVk5neVXki3fG4pAubfpGRC5K8YrWIxXsBivYDFewWK8gsV4BYvxChbjFSzGK1iMV7AYr2AxXsFivILFeAWL8QoW4xUsxitYjFewGK9giY930Csc15cvjsrlgxvve3ly/dbqd3aerXH+3tZjEDHe3iTY6cuLMN7twnjrYHfPyuVT40VhvHWwdRulza2MVxZjvFWuH+7XTZ7v73w6jvcfv6sufvB1e6+XX1aBf/7zKN5/VTfuPH5eLs7H+/LL/V7v4ednw2tTqdbrxy+r6+88H15+t9/b+UP78Ls/f1P9SjO16pZH1W88/KJc7leP9vf96v6jx6invfPB8+H1iZ/vV9P58dHoVzMw3iqA3xzV44Z+78FXbbztSng0nhjs11fe+aS5td/ctlM28+bibe/Z/N7sVKp4P6yvPfh+soqvHv7h/mRq7cil19trHub9cvcX7WOct9NuNi9nJ17dVubu9leOrmG8ZXGfljiqGna/bRf+qKGmomYvxDiNwehyKWo23sk9965NZXKt5cGLqWmNr1Yt9ptJt8+RJ+1jVPO388Xw8tvmnnMTH4fd3hqB8ZY1WXmBLokcDCZ57lav7t80q7lS0Udnw5ef1LeWVd5uc21vPt6S3df1PaqE5qZSantyVq8wq5FDG2i5T/mN9llzWt+zlNg+7F5ZrTaP0T5SeX4cX5vF8isl7dPRijkB4y1Lu4wYz6pLx4NxQ+PX/b3232FTyEH5t861WUvOxDvaojt///Of5qcyutrvTQc6GMU2unOh7bPteyreKvu//NTcZ27i7eTGPyMw3lJP1cWDF6fV/4PxurUZOfZLIuOrzYXZV/qZeNvqGuamUnLbax6wvLBPVqDNy/zowuU//1w22dp4m57bx2gHCjtla3B+4qNn1MwcdB3jrUOpuvjjUbP2bQYQbQGDdntpso00E+/kxbxhJp25qawU7+WXo0kviHe8idauhqcnbryJDOoW+vVGfxPmCmveqW2iN7rmrfN8+NlfjxbG2+4r642GMnNr3no6xptEE2+zsX7cjmoXjFZnx7xTfSwc8148ffz9TVO5Fu/UmLed9MVN8Vb857v90VNhbsxrvHEMxq/C7avvLXsbjsbr5QfPR9Vc39vwxej3ru9tWBxvuwNsslKf7G2Yjne0km42FK/vbTDeOJp4642h5tW3xDseXd59P281sbmp3BjvZOuvefh6l9z1eOtnS/UUOlk0i8abyGCyv/VgNDCYSuNxXU97CGDn0cwRtmaEsPgI2/SbJdqp3Djm/XTyG5MjDwfXhw3jAxGzh+8et0fYjDeO2VfqsuxvfG/D4+en7a3Njbe8t+Gjxe9tuGGD7cfxexvKmx56H3w/GB1omx3zNm98GM/U3HsbjFfeLoOkw7lvGuPdLMb7GhjvZjHe18B4N4vxvgbGu1mM9zUwXsFivILFeAWL8QoW4xUsxitYjFewdDfeHzY9A1sP3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEMdjffq1av/vrra9FxsOca7lby6urr699XVq03Px3ZjvNtIabfEa723YrxbSN1uHa/13obxbh9XV8a7Esa7fbyaitd6b8F4tw/jXRHj3T6Md0WMd/sw3hUx3u3DDbYVMd4txF1lq2G824gHKVbCeLcSDw+vgvFuJ74xZwWMd2vBL5q1gzdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN2S8ueANGW8ueEPGmwvekPHmgjdkvLngDRlvLnhDxpsL3pDx5oI3ZLy54A0Zby54Q8abC96Q8eaCN7Qw3suT3oMXzcXz/d7u2ducoTcGftGsHbyhhfGe7pX/ChdHB8P+3ludozcFftGsHbyhRfFePH02PH+vXvWWH+UqEPyiWTt4Q4vinSp2Nt4fRDbEHeK9ODoe9nvHb+R58pbBr1fWDt7QknjLBtuTE+PtJHhDy+IdDh3zdhW8oSUbbIWpiyTwi2bt4A0t21VWdXzqrrJugje0MN6Lo/ogxenBcDjoeZCiq+ANeXg4F7wh480Fb8h4c8EbMt5c8IaMNxe8IePNBW/IeHPBGzLeXPCGjDcXvCHjzQVvyHhzwRsy3lzwhow3F7wh480Fb8h4c8EbMt5c8IaMNxe8IePNBW/IeHPBGzLeXPCGjDcXvCHjzQVvyHhzwRsy3lzwhow3F7wh480Fb8h4c8EbMt5c8IaMNxe8IePNBW/IeHPBGzLeXPCGjDcXvCHjzQVvyHhzwRta4Yuzd5DfZMVfNGsHb2jpF2cfD/sP/CqrToI35Bdn54I3tOQbMC9PjocD5ndZ4RfN2sEbWvb1rdXwd9Lupr/5W3K5Q7wXRweOebsK3tCSeB3zdhi8ITfYcsEbWrKr7PLEYUNnwRta9sXZHqToLnhDHh7OBW/IeHPBGzLeXPCGjDcXvCHjzQVvyHhzwRsy3lzwhow3F7wh480Fb8h4c8EbMt5c8IaMNxe8IePNBW/IeHPBGzLeXPCGjDcXvCHjzQVvyHhzwRsy3lzwhow3F7wh480Fb2jJKU4HvcLBW52lNwR+0awdvKEl520oDDxvQzfBG1pyxpxhc4peIvhFs3bwhpadJXI47HuWSNk8d4q3nKEXCX69snbwhpbGOxk/wMAvmrWDN7Q03v7egnsQwC+atYM3tHSD7RS5n2zYgUWzdvCGlu0qww55+Ytm7eANLTvFKfTM0sMOLJq1gzfk4eFc8IaMNxe8IePNBW/IeHPBGzLeXPCGjDcXvCHjzQVvyHhzwRsy3lzwhow3F7wh480Fb8h4c8EbMt5c8IaMNxe8oSXnbSgXmadt4C+atYM3tOzN6Ke7Z+fvIt/Si180awdvaMnHgLjvRecvmrWDN7TkA5jYzw53YNGsHbyhJfEOdr/t9cafYtv0iSckl7vEW22tDXaQQwf8emXt4A0tXfOeUT9AjF80awdvaMkGW/lhvB0Fb2jprrIDT3HaVfCGlp23oRykQK54+Ytm7eANeXg4F7wh480Fb8h4c8EbMt5c8IaMNxe8IePNBW/IeHPBGzLeXPCGjDcXvCHjzQVvyHhDObx//979w03PxethvJncPzw8/Pjw8P6m5+O1MN5ISrslXna9yz76fr7f602+fJiE8d5M3W4dL7reZe/nHVC/ANN4b+bwsLvxTn8DJvYLMI33Zu5PxUuud8ln2C7/hPzwZcF4byQk3ounj3qTDw9v+uPP8ma49/EU9zY9N6txh3jLqZ4ufutn2LpFyJq3AD3lk/HeSMoG29B4O0jGrrLysffzX7uft2t0+CDF1Eff+70e87QNxnsrHh7eaoz3VnxjzjZjvMvAGzLeXPCGjDcXvCHjzQVvyHhzwRsy3lzwhow3F7wh480Fb6i78UrnMV7BYryCxXgFi/EKFuMVLMYrWIxXsBivYEHHW06k1lvlc0rt1ydPfao0h+aPPt9nfo/prbDjXTXG+HjL+Te6h/F2nbmzcHSJbsR7/t5Xvd7BcDjo1Senaj79fHny2X5vrxpa7FUXf19ur5fjEfXj0Hek+qMvjkZjhiknIxOVs+ranEEG7HibMW+lfv+gnGKirGAGu2dlPdsvP3bPLo52z6qXzObicbUc29s2PedvkfP3/nYyPk/tjJPaRAl7sPNs1uAm5/cXwI53vOZ999nUGqZ9oSxLp/2/Hjac7lU3dPhF9AbO3330q5PRiWqnnMycTvHZrEEIHYm3utCOCXrHzQp551q8/Tre5rbNzvdbpexnGG+vTcfbmig/qzXvjEEI3Yp3WJ+gqr10bc170K55s6j/4n47zp9b8w7b84A+fTZrcIOz+0voVLxlQVTqy9Jph7fjeKth3v5ozJsVcP3XXrbD3rkndHVbSfV0vOZtDW54lleFHW+zwdY7Hq03Jnsbqh8zC2p6b0PUqGF8kKKud8rJ2FKv9+Rk3iADdLySjfEKFuMVLMYrWIxXsBivYDFewWK8gsV4BYvxChbjFSzGK1iMV7AYr2AxXsFivILFeAWL8QoW4xUsxitYjFew3PufCJT/A2j+D8Z28la3AAAAAElFTkSuQmCC"></p>



<hr>
</div>
<div id="conclusion" class="section level1">
<h1>Conclusion</h1>
<p>This dataset was very clean and ready for a machine learning algorithm, however it still needed some modifications in order to make the predictions more accurate. Then, after analizing the data and using some visualization tools, a prediction model for the data was created. Altought the first approach wasn’t the best one, the ones created after were really accurate. At the end I got an accuracy of <strong><em>0.9975654</em></strong> for the Random Forest method, this accuracy is even better than the accuracy of all the methods combined. Therefore I think this model can be used in the real life for Fraud detection because of the very low error margin. However there’s still room for improvement, for example I could use the origin and destination data in addtion to all the predictors that I used to try and improve the algorithm, or create a Desicion Tree with all the predictors and see if the overall accuracy is better than the one that I got</p>

</div>
</div>
















