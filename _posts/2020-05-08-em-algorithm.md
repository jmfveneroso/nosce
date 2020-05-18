---
title: Expectation Maximization (EM) Algorithm
description: Practical examples of the EM Algorithm.
header: Expectation Maximization (EM) Algorithm
---

&nbsp;

The 
[Expectation Maximization (EM) Algorithm](https://en.wikipedia.org/wiki/Expectation%E2%80%93maximization_algorithm) 
is an optimization method often used to perform 
[Maximum Likelihood Estimation (MLE)](https://en.wikipedia.org/wiki/Maximum_likelihood_estimation) 
for models with latent variables. 

This article aims to explain how to perform Maximum Likelihood Estimation using
the EM Algorithm by studying two problems: the Multinomial Estimation and the 
Gaussian Mixture Model Estimation.


## Multinomial Estimation

Before considering the EM algorithm, let's understand how to perform MLE for a 
model without latent variables. Then, we will proceed to understand how to 
optimize a model with latent variables using the EM algorithm.


### MLE for a Multinomial Model without Latent Variables

A machine with a button can generate one of 4 symbols ( H, J, K, L ). Every 
time the button is pressed, the machine generates each symbol according to the
following probabilities:

<img class="equation" src="img/eq1.png" height="42px" />
<!--
\left( \frac{1}{2} + \frac{\alpha}{4}, \frac{1-\alpha}{4}, \frac{1-\alpha}{4}, 
\frac{\alpha}{4} \right)
-->

This machine has a tunable parameter <img class="inline-img" src="img/alpha_small.png" />
ranging from 0 to 1 that controls the probabilities above, but let's assume that
someone else tuned the machine so we don't know its value. 

By drawing a few samples we'll try to estimate the value of 
<img class="inline-img" src="img/alpha_small.png" />.
After pressing the button 197 times, we produced the following counts for
each symbol:

<img class="equation" src="img/eq2.png" height="21px" />
<!--
x = \left( x_1, x_2, x_3, x_4 \right) = \left( 125, 18, 20, 34 \right)
-->

Following from the definition of our machine, the probability of observing 
<img class="inline-img" src="img/x_small.png" /> follows a multinomial 
distribution and therefore the likelihood is:

<img class="equation" src="img/eq3.png" height="42px" />
<!--
\mathcal {L}(\alpha|x) = P(x|\alpha) = 
\frac{(x_1 + x_2 + x_3 + x_4)!}{x_1!x_2!x_3!x_4!} 
\left( \frac{1}{2} + \frac{\alpha}{4} \right) ^ {x_1}
\left( \frac{1-\alpha}{4} \right) ^ {x_2 + x_3}
\left( \frac{\alpha}{4} \right) ^ {x_4}
-->

<img src="img/likelihood.png" />

In the plot, we see that the likelihood for our multinomial model has a single 
critical point that is also the maximum.
Optimizing the log-likelihood is easier than optimizing the likelihood because
it is a monotonic transformation that turns products into sums, what 
makes taking the derivatives easier.
The log-likelihood for our multinomial model is:

<img class="equation" src="img/eq4.png" height="42px" />
<!--
\ell (\alpha|x) = \ln \frac{(x_1 + x_2 + x_3 + x_4)!}{x_1!x_2!x_3!x_4!} + 
x_1 \ln \left( \frac{1}{2} + \frac{\alpha}{4} \right) +
(x_2 + x_3) \ln \left( \frac{1-\alpha}{4} \right) +
x_4 \left( \frac{\alpha}{4} \right)
-->

And the Maximum Likelihood Estimator for
<img class="inline-img" src="img/alpha_small.png" />
is:

<img class="equation" src="img/eq5.png" height="42px" />
<!--
\hat{\alpha} = \text{argmax}_{\alpha} \ell (\alpha|x)
-->

Taking the first derivatives of the log-likelihood and making them equal to
zero should be sufficient to find the maximum likelihood estimator:

<img class="equation" src="img/eq6.png" height="42px" />
<!--
\frac{\partial \ell (\alpha|x)}{\partial \alpha} = \frac{x_1}{2 + \alpha} -
\frac{x_2 + x_3}{1 - \alpha} + \frac{x_4}{\alpha} = 0
-->

<img class="equation" src="img/eq7.png" height="42px" />
<!--
\frac{\partial \ell (\alpha|x)}{\partial \alpha} = \frac{x_1(\alpha - \alpha^2) -
(x_2 + x_3)(2\alpha + \alpha^2) + x_4 (2 - \alpha - \alpha^2)}{(2 + \alpha)(1 - \alpha)\alpha} = 0
-->

<img class="equation" src="img/eq8.png" height="21px" />
<!--
-(x_1 + x_2 + x_3 + x_4) \alpha^2 + (x_1 - 2x_2 - 2x_3 - x_4) \alpha + 2 x_4 = 0
-->

Substituting the values for 
<img class="inline-img" src="img/x_small.png" /> we get:

<img class="equation" src="img/eq9.png" height="21px" />
<!--
-197 \alpha^2 + 15 \alpha + 68 = 0
-->

Which is a simple quadratic equation that can be solved with Bhaskara's formula:

<img class="equation" src="img/eq10.png" height="42px" />
<!--
\alpha = \frac{-15 \pm \sqrt{53584}}{-394}
-->

Solving the equation, we find the roots:

<img class="equation" src="img/eq11.png" height="42px" />
<!--
\alpha' = 0.62558929121 \\
\alpha'' = -0.54944715923
-->

By definition, <img class="inline-img" src="img/alpha_small.png" />
can't be negative so the the Maximum Likelihood Estimate for 
<img class="inline-img" src="img/alpha_small.png" /> is 0.62558929121.

<img src="img/mle.png" />

So far, finding the MLE for this model has been pretty straightforward. Now
let's try to find the estimates for a model with latent variables by reframing
the same problem.


### MLE for a Multinomial Model with Latent Variables

Latent variables are random variables that cannot be observed directly. In the
multinomial model that we saw previously there were no such variables. We will 
now reframe the same problem by assuming some latent variables and use the
EM Algorithm to obtain the Maximum Likelihood Estimator for
<img class="inline-img" src="img/alpha_small.png" />.

Now consider that we have a hypothesis of how the machine works internally.
Assume that the machine that was previously described generates 5 symbols
(A, B, C, D, E) once the button is pressed with the following probabilities:

<img class="equation" src="img/eq12.png" height="42px" />
<!--
\left( \frac{1}{2}, \frac{\alpha}{4}, \frac{1-\alpha}{4}, \frac{1-\alpha}{4}, 
\frac{\alpha}{4} \right) 
-->

But before producing any output, it converts the generated symbols to a symbol 
from the set (H, J, K, L) according to the following rules:

- A and B become H
- C becomes J
- D becomes K
- E becomes L

Note that the probability of observing each symbol
from the set (H, J, K, L) is the same as before. That is:

<img class="equation" src="img/eq1.png" height="42px" />
<!--
\left( \frac{1}{2} + \frac{\alpha}{4}, \frac{1-\alpha}{4}, \frac{1-\alpha}{4}, 
\frac{\alpha}{4} \right)
-->

If we observe J, K or L being output from the machine, we know for sure that the 
machine generated either C, D or E internally. However, if it outputs H, we 
don't know if it generated A or B internally.

As in the previous problem, <img class="inline-img" src="img/alpha_small.png" /> 
is still an unknown parameter that was set beforehand and we will draw a few
samples to estimate its value.

After producing 197 samples from this model, we observe the following counts:

<img class="equation" src="img/eq2.png" height="21px" />
<!--
x = \left( x_1, x_2, x_3, x_4 \right) = \left( 125, 18, 20, 34 \right)
-->

This is the observed data. Underlying it, there is also an unobserved output 
produced internally by the machine:

<img class="equation" src="img/eq13.png" height="21px" />
<!--
y = \left( y_1, y_2, y_3, y_4, y_5 \right) = \left( ?, ?, 18, 20, 34 \right)
-->

These "internal variables" are the latent variables of this model, because they
are not observed directly. 

The incomplete-likelihood (considering only the observed data) is the
same as before:

<img class="equation" src="img/eq3.png" height="42px" />
<!--
\mathcal {L}(\alpha|x, y) = P(x, y|\alpha) = 
\frac{(y_1 + y_2 + y_3 + y_4 + y_5)!}{y_1!y_2!y_3!y_4!y_5!} 
\left( \frac{1}{2} \right) ^ {y_1}
\left( \frac{\alpha}{4} \right) ^ {y_2 + y_5}
\left( \frac{1-\alpha}{4} \right) ^ {y_3 + y_4}
-->

And the complete-data likelihood (considering both observed and unobserved 
variables) is:

<img class="equation" src="img/eq15.png" height="42px" />
<!--
\mathcal {L}(\alpha|x) = P(x|\alpha) = 
\frac{(x_1 + x_2 + x_3 + x_4)!}{x_1!x_2!x_3!x_4!} 
\left( \frac{1}{2} + \frac{\alpha}{4} \right) ^ {x_1}
\left( \frac{1-\alpha}{4} \right) ^ {x_2 + x_3}
\left( \frac{\alpha}{4} \right) ^ {x_4}
-->

And the complete log-likelihood is:

<img class="equation" src="img/eq16.png" height="42px" />
<!--
\ell (\alpha|x, y) = 
\ln \frac{(y_1 + y_2 + y_3 + y_4 + y_5)!}{y_1!y_2!y_3!y_4!y_5!} +
y_1 \ln \left( \frac{1}{2} \right) +
y_2 \ln \left( \frac{\alpha}{4} \right) +
(y_3 + y_4) \ln \left( \frac{1-\alpha}{4} \right) +
y_5 \ln \left( \frac{\alpha}{4} \right)
-->

We know that 
<img class="inline-img" src="img/eq14.png" /> 
but we don't know the exact values for 
<img class="inline-img" src="img/y1_small.png" /> 
and 
<img class="inline-img" src="img/y2_small.png" />.
We could optimize the complete likelihood as we did before, but instead we'll
optimize the incomplete likelihood to show how the EM Algorithm works.
If we knew the values for y, optimization would be straightforward, but since
we don't, we need some sorcery.

----------

#### The theory of the EM Algorithm

The EM Algorithm is an iterative procedure that works in two steps: the 
expectation step and the optimization step. The 
expectation step consists of calculating the expected value of the log-likelihood 
function with respect to the conditional distribution of the latent variables 
<img class="inline-img" src="img/y_small.png" /> 
given the observed data 
<img class="inline-img" src="img/x_small.png" /> 
and the parameter
<img class="inline-img" src="img/alpha_small.png" /> 
from the previous step:

<img class="equation" src="img/eq17.png" height="21px" />
<!--
Q(\alpha|\alpha^{(t)}) = E_{y|x,\alpha^{(t)}} \left[ \ell (\alpha|x, y) \right]
-->

And the maximization step consists of obtaining the parameters that optimize this 
expression:

<img class="equation" src="img/eq18.png" height="42px" />
<!--
\alpha^{(t+1)} = \argmax_{\alpha} \: q(\alpha|\alpha^{(t)})
-->

With the new parameters, we repeat this procedure iteratively until the 
parameters converge. 
The EM algorithm has the nice property of increasing the likelihood at each 
iteration monotonically, however it does not guarantee that the point of 
convergence will be a global maximum, only a local maximum. 

----------

#### The Expectation Step

Our next task is to calculate the Expectation Step for the multinomial 
problem. That is:

<img class="equation" src="img/eq20.png" height="42px" />
<!--
E_{y|x,\alpha^{(t)}} \left[ \ell (\alpha|x, y) \right] = E_{y|x,\alpha^{(t)}} \left[
\ln \frac{(y_1 + y_2 + y_3 + y_4 + y_5)!}{y_1!y_2!y_3!y_4!y_5!} +
y_1 \ln \left( \frac{1}{2} \right) +
(y_2 + y_5) \ln \left( \frac{\alpha}{4} \right) +
(y_3 + y_4) \ln \left( \frac{1-\alpha}{4} \right) \right]
-->

Remembering that:
<img class="equation" src="img/eq19.png" height="42px" />
<!--
E_{y|x,\alpha} \left[ \ell (\alpha|x, y)  \right] = 
\sum_{y'} P(y'|x,\alpha) \; \ell (\alpha|x, y')
-->

This is the value of the complete log-likelihood considering all the possible 
values for variables 
<img class="inline-img" src="img/y1_small.png" /> 
and 
<img class="inline-img" src="img/y2_small.png" /> 
weighted by the probability of those values considering what we know about the
observed data. We know that 
<img class="inline-img" src="img/eq14.png" />, 
so the possible
values for 
<img class="inline-img" src="img/y1_small.png" /> 
and 
<img class="inline-img" src="img/y2_small.png" /> 
are: (0, 125), (1, 124), (2, 123) ... (125, 0).

The expected log-likelihood can be split into four terms:

<img class="equation" src="img/eq21.png" height="42px" />
<!--
E_{y|x,\alpha^(t)} \left[ \ell (\alpha|x, y) \right] = 
E \left[ \ln C \right] +
E \left[ y_1 \ln \left( \frac{1}{2} \right) \right] +
E \left[ (y_3 + y_4) \ln \left( \frac{1-\alpha}{4} \right) \right] +
E \left[ (y_2 + y_5) \ln \left( \frac{\alpha}{4} \right) \right]
-->

Where:

<img class="equation" src="img/eq22.png" height="42px" />
<!--
C = \frac{(y_1 + y_2 + y_3 + y_4 + y_5)!}{y_1!y_2!y_3!y_4!y_5!}
-->

We also omit the subscript of the Expected Value operator to shorten the 
right-hand side.

We don't really care about the two first terms because they will disappear
after we take the first derivative relative to 
<img class="inline-img" src="img/alpha_small.png" />, so we'll focus on the
third and fourth terms, which we call term A and B respectively.

----

#### Term A

<img class="equation" src="img/eq23.png" height="42px" />
<!--
E_{y|x,\alpha^{(t)}} \left[ (y_3 + y_4) \ln \left( \frac{1-\alpha}{4} \right) \right] =
E_{y|x,\alpha^{(t)}} \left[ (x_2 + x_3) \ln \left( 1-\alpha \right) \right] - 
E_{y|x,\alpha^{(t)}} \left[ (x_2 + x_3) \ln 4 \right]
-->

Note that the second term in this equation will disappear once we take the
first derivative. While the first term is simply:

<img class="equation" src="img/eq24.png" height="20px" />
<!--
E_{y|x,\alpha^{(t)}} \left[ (x_2 + x_3) \ln \left( 1-\alpha \right) \right] =
(x_2 + x_3) \ln \left( 1-\alpha \right)
-->

This happens because the first term is constant relative to every possibile
value of 
<img class="inline-img" src="img/y_small.png" /> and the expectation of a
constant is the constant itself.

----

#### Term B

<img class="equation" src="img/eq25.png" height="42px" />
<!--
E_{y|x,\alpha^{(t)}} \left[ (y_2 + y_5) \ln \left( \frac{\alpha}{4} \right) \right] = 
E_{y|x,\alpha^{(t)}} \left[ (y_2 + x_4) \ln \left( \alpha \right) \right] -
E_{y|x,\alpha^{(t)}} \left[ (y_2 + x_4) \ln \left( 4 \right) \right] 
-->

Once again, the second term in the equation will disappear once we take the
first derivative. And the first term is:

<img class="equation" src="img/eq26.png" height="20px" />
<!--
E_{y|x,\alpha^{(t)}} \left[ (y_2 + x_4) \ln \left( \alpha \right) \right] =
E_{y|x,\alpha^{(t)}} \left[ y_2 \ln \left( \alpha \right) \right] + E_{y|x,\alpha^{(t)}} \left[ x_4 \ln \left( \alpha \right) \right] =
\ln \left( \alpha \right) E_{y|x,\alpha^{(t)}} \left[ y_2 \right] + x_4 \ln \left( \alpha \right)
-->

So the only expectation we need to calculate is:

<img class="equation" src="img/eq27.png" height="26px" />
<!--
E_{y|x,\alpha^{(t)}} \left[ y_2 \right]
-->

----

#### The expectation of y2

<img class="equation" src="img/eq28.png" height="55px" />
<!--
E_{y|x,\alpha^{(t)}} \left[ y_2 \right] = \sum_{i=0}^{125} P(y_2=i|x, \alpha) \; y_2
-->

The question is how to calculate the conditional probabilities. Note that:

<img class="equation" src="img/eq29.png" height="42px" />
<!--
P(y|x, \alpha^{(t)}) = \frac{P(x, y|\alpha^{(t)})}{P(x|\alpha^{(t)})}
-->

And we already know these probabilities:

<img class="equation" src="img/eq30.png" height="42px" />
<!--
P(x|\alpha) = 
\frac{(x_1 + x_2 + x_3 + x_4)!}{x_1!x_2!x_3!x_4!} 
\left( \frac{1}{2} + \frac{\alpha}{4} \right) ^ {x_1}
\left( \frac{1-\alpha}{4} \right) ^ {x_2 + x_3}
\left( \frac{\alpha}{4} \right) ^ {x_4}
-->

<img class="equation" src="img/eq31.png" height="42px" />
<!--
P(x, y|\alpha) = P(y|\alpha) = 
\frac{(y_1 + y_2 + y_3 + y_4 + y_5)!}{y_1!y_2!y_3!y_4!y_5!} 
\left( \frac{1}{2} \right) ^ {y_1}
\left( \frac{\alpha}{4} \right) ^ {y_2}
\left( \frac{1-\alpha}{4} \right) ^ {y_3 + y_4}
\left( \frac{\alpha}{4} \right) ^ {y_5}
-->

Simply replacing these definitions in the conditional probability equation we get:

<img class="equation" src="img/eq32.png" height="56px" />
<!--
P(y|x, \alpha) = 
\frac{(y_1 + y_2 + y_3 + y_4 + y_5)!}{y_1!y_2!y_3!y_4!y_5!} 
\frac{x_1!x_2!x_3!x_4!}{(x_1 + x_2 + x_3 + x_4)!}
\frac{
\left( \frac{1}{2} \right) ^ {y_1}
\left( \frac{\alpha}{4} \right) ^ {y_2 + y_5}
\left( \frac{1-\alpha}{4} \right) ^ {y_3 + y_4}
}{
\left( \frac{1}{2} + \frac{\alpha}{4} \right) ^ {x_1}
\left( \frac{1-\alpha}{4} \right) ^ {x_2 + x_3}
\left( \frac{\alpha}{4} \right) ^ {x_4}
}
-->

Also, knowing that:

<img class="equation" src="img/eq33.png" height="18px" />
<!--
x_1 = y_1 + y_2, x_2 = y_3, x_3 = y_4, x_4 = y_5
-->

We get:

<img class="equation" src="img/eq34.png" height="42px" />
<!--
P(y|x, \alpha) = 
\frac{(y_1 + y_2 + y_3 + y_4 + y_5)!}{(y_1 + y_2 + y_3 + y_4 + y_5)!} 
\frac{(y_1 + y_2)!y_2!y_3!y_4!y_5!}{y_1!y_2!y_3!y_4!y_5!} 
\frac{
\left( \frac{1}{2} \right) ^ {y_1}
\left( \frac{\alpha}{4} \right) ^ {y_2}
\left( \frac{1-\alpha}{4} \right) ^ {y_3 + y_4}
\left( \frac{\alpha}{4} \right) ^ {y_5}
}{
\left( \frac{1}{2} + \frac{\alpha}{4} \right) ^ {y_1 + y_2}
\left( \frac{1-\alpha}{4} \right) ^ {y_3 + y_4}
\left( \frac{\alpha}{4} \right) ^ {y_5}
}
-->

<img class="equation" src="img/eq35.png" height="56px" />
<!--
P(y|x, \alpha) = 
\frac{(y_1 + y_2)!}{y_1!y_2!} 
\left( \frac{\frac{1}{2}}{\frac{1}{2} + \frac{\alpha}{4}} \right) ^ {y_1}
\left( \frac{\frac{\alpha}{4}}{\frac{1}{2} + \frac{\alpha}{4}} \right) ^ {y_2}
-->

And this is just a binomial distribution:

<img class="equation" src="img/eq36.png" height="42px" />
<!--
P(y|x,\alpha) = P(y_2=i|x,\alpha) = 
B \left(125, \frac{\frac{\alpha}{4}}{\frac{1}{2} + \frac{\alpha}{4}} \right)
-->

And the expected value of 
<img class="inline-img" src="img/y2_small.png" /> is the expected value of this
binomial distribution:

<img class="equation" src="img/eq37.png" height="42px" />
<!--
E_{y|x,\alpha} \left[ y_2 \right] = 125 \left( \frac{\frac{\alpha}{4}}{\frac{1}{2} + \frac{\alpha}{4}} \right)
-->

-----

#### The Optimization Step

We can replace the relevant terms in the expected log-likelihood and get 
(omitting the terms that will disappear once we take the first 
derivative):

<img class="equation" src="img/eq38.png" height="25px" />
<!--
E_{y|x,\alpha^{(t)}} \; \ell (\alpha|x, y) = \ldots +
(x_2 + x_3) \ln \left( 1-\alpha \right) +
\ln \left( \alpha \right) E_{t|x,\alpha^{(t)}} \left[ y_2 \right] +
x_4 \ln \left( \alpha \right)
-->

The derivative relative to 
<img class="inline-img" src="img/alpha_small.png" />
is:

<img class="equation" src="img/eq39.png" height="42px" />
<!--
\frac{\partial E_{y|x,\alpha^{(t)}} \left[ \ell (\alpha|x, y) \right]}{\partial \alpha}  = 
\frac{y_1 + x_4}{\alpha} - \frac{x_2 + x_3}{1 - \alpha}
-->

What yields:

<img class="equation" src="img/eq40.png" height="42px" />
<!--
\alpha = \frac{y_1 + x_4}{y_1 + x_2 + x_3 + x_4}
-->

Note that the expected value of 
<img class="inline-img" src="img/y2_small.png" /> 
was treated as a constant when we took the derivative, even though it contains
<img class="inline-img" src="img/alpha_small.png" /> 
in its definition. The
trick here is that we are taking the derivative to find the next alpha, and
the expected value of 
<img class="inline-img" src="img/y2_small.png" /> 
was calculated using the previous
<img class="inline-img" src="img/alpha_small.png" />.
This assumption makes the EM algorithm possible.

-----

#### The EM Algorithm for the Multinomial Problem

In summary, our algorithm consists of 2 steps:

Step 1:
<img class="equation" src="img/eq41.png" height="42px" />
<!--
\hat{y_2}^{(t+1)} = E_{y|x,\hat{\alpha}^{(t)}} \left[ y_2 \right] = 125 \left( \frac{\frac{\hat{\alpha}^{(t)}}{4}}{\frac{1}{2} + \frac{\hat{\alpha}^{(t)}}{4}} \right)
-->

Step 2:
<img class="equation" src="img/eq43.png" height="42px" />
<!--
\hat{\alpha}^{(t+1)} = \frac{\hat{y_2}^{(t+1)} + x_4}{\hat{y_2}^{(t+1)} + x_2 + x_3 + x_4}
-->

Repeat these steps iteratively until the parameters converge. Starting with
<img class="inline-img" src="img/alpha_small.png" /> = 0.1, the algorithm
converges quite close to the true value of 0.62558929121 after just a few 
iterations.

<table class="my-table">
  <thead>
    <th>Iteration</th>
    <th><img class="inline-img" src="img/y2_small.png" /></th>
    <th><img class="inline-img" src="img/alpha_small.png" /></th>
  </thead>
  <tbody>
    <tr><td>0</td><td> ---</td><td>0.100</td></tr>
    <tr><td>1</td><td> 5.952</td><td>0.512</td></tr>
    <tr><td>2</td><td>25.498</td><td>0.610</td></tr>
    <tr><td>3</td><td>29.223</td><td>0.624</td></tr>
    <tr><td>4</td><td>29.747</td><td>0.626</td></tr>
    <tr><td>5</td><td>29.817</td><td>0.626</td></tr>
    <tr><td>6</td><td>29.826</td><td>0.626</td></tr>
  </tbody>
</table>

The same process graphically:

<img src="img/em_pos.gif" />

We could start it with a different 
<img class="inline-img" src="img/alpha_small.png" /> 
(0.9) and it
still finds the maximum after a couple of iterations.

<img src="img/em_neg.gif" />

A bonus of using the EM algorithm is that in addition to the Maximum Likelihood
estimates for 
<img class="inline-img" src="img/alpha_small.png" /> 
we also get estimates for
<img class="inline-img" src="img/y1_small.png" /> 
and
<img class="inline-img" src="img/y2_small.png" />.

The EM algorithm functions as an
optimization in two fronts, finding the best values for 
<img class="inline-img" src="img/y1_small.png" />,
<img class="inline-img" src="img/y2_small.png" /> 
and 
<img class="inline-img" src="img/alpha_small.png" /> 
on each iteration. The animation below shows
how the estimates get closer to the true maximum likelihood as we perform more 
iterations. The height dimension represents the likelihood.

<img src="img/3d.gif" />


## Gaussian Mixture Model

In the previous example we saw how the EM Algorithm works using a toy problem.
But a more common application of the EM algorithm is to find the Maximum Likelihood
Estimators for the parameters of a Gaussian Mixture Model.

Consider the following dataset:

<img class="equation" src="img/eq44.png" height="18px" />
<!--
x = \{ -0.39, 0.12, 0.94, 1.67, 1.76, 2.44, 3.72, 4.28, 4.92, 5.53, 
0.06, 0.48, 1.01, 1.68, 1.80, 3.25, 4.12, 4.60, 5.28, 6.22 \}
-->

That produces the following histogram:

<img src="img/histogram.png" />

We don't know which distribution generated the example dataset,
but a mixture of two normals seems to be a good fit. Something like:

<img src="img/mixture_example.png" />

Let 
<img class="inline-img" src="img/normal_small.png" /> 
describe a normal distribution
with mean 
<img class="inline-img" src="img/mu_small.png" /> 
and variance 
<img class="inline-img" src="img/sigma_small.png" />
.
Then, we can describe the mixture of two normals with the following equation 
for the probability density:

<img class="equation" src="img/eq45.png" height="18px" />
<!--
f(x_i; \theta) = \alpha \phi_1(x_i, \mu_1, \sigma_1) + (1 - \alpha) \phi_2(x_i, \mu_2, \sigma_2)
-->

Where 
<img class="inline-img" src="img/theta_small.png" />
represents all the parameters of our mixture model. That is: 
<img class="inline-img" src="img/mu1_small.png" />,
<img class="inline-img" src="img/sigma1_small.png" />,
<img class="inline-img" src="img/mu2_small.png" />,
<img class="inline-img" src="img/sigma2_small.png" /> and
<img class="inline-img" src="img/alpha_small.png" />.
Where 
<img class="inline-img" src="img/alpha_small.png" />
is the prior probability that the data point came from 
the first normal
<img class="inline-img" src="img/phi1_small.png" />.

The log-likelihood of our model is:

<img class="equation" src="img/eq46.png" height="42px" />
<!--
\ell (\theta|x) = \sum_{i=0}^N \ln \bigg( \alpha \; \phi_1(x_i, \mu_1, \sigma_1) + 
(1 - \alpha) \; \phi_2(x_i, \mu_2, \sigma_2) \bigg)
-->

This expression is not terribly hard to optimize. In fact, you can compute the
first derivatives and use Gradient Ascent to get Maximum Likelihood estimates 
for the parameters as we'll show later in this section. But there are problems
where Gradient Ascent won't be viable, so we'll first understand how to use the
EM Algorithm to solve the parameter estimation for a Mixture Model.

The EM algorithm framework for this problem works by assuming that we
have a latent variable 
<img class="inline-img" src="img/yi_small.png" />
for each data point that is either 1 when the data point came from the first
normal distribution or 0 when it came from the second distribution. 
Also, we assume that:

<img class="equation" src="img/eq52.png" height="20px" />
<!--
P(Y_i=1) = \alpha
-->

With these definitions, we can write the likelihood as:

<img class="equation" src="img/eq53.png" height="28px" />
<!--
\mathcal {L}(\theta|x, y) = P(x, y|\theta) = \Pi_{i=0}^N 
\left[ \alpha \phi_1(x_i, \mu_1, \sigma_1)       \right]^{y_i} 
\left[ (1 - \alpha) \phi_2(x_i, \mu_2, \sigma_2) \right]^{(1-y_i)}
-->

And the log-likelihood:

<img class="equation" src="img/eq54.png" height="42px" />
<!--
\ell (\theta|x, y) = \sum_{i=0}^N 
y_i       \left[ \ln \alpha + \ln \phi_1(x_i, \mu_1, \sigma_1) \right] + 
(1 - y_i) \left[ \ln (1 - \alpha) + \ln \phi_2(x_i, \mu_2, \sigma_2) \right]
-->

----

#### The Expectation Step

The first step of the EM algorithm is to compute the expected log-likelihood
with respect to the conditional distribution of the latent variables. That is:

<img class="equation" src="img/eq55.png" height="42px" />
<!--
E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right] = 
\sum_{i=0}^N 
E_{y|x,\theta^{(t)}} \bigg[ 
y_i       \left[ \ln \alpha + \ln \phi_1(x_i, \mu_1, \sigma_1) \right] + 
(1 - y_i) \left[ \ln (1 - \alpha) + \ln \phi_2(x_i, \mu_2, \sigma_2) \right]
\bigg]
-->

Which is basically:

<img class="equation" src="img/eq56.png" height="42px" />
<!--
E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right] = 
\sum_{i=0}^N 
P(y_i=1|x_i,\theta) \left[ \ln \alpha + \ln \phi_1(x_i, \mu_1, \sigma_1)       \right] + 
P(y_i=0|x_i,\theta) \left[ \ln (1 - \alpha) + \ln \phi_2(x_i, \mu_2, \sigma_2) \right]
-->

We can calculate the conditional probabilities using Bayes' Theorem:

<img class="equation" src="img/eq57.png" height="42px" />
<!--
P(y_i=1|x_i,\theta) = \frac{P(x_i|y_i=1|\theta)P(y_i=1|\theta)}{
P(x_i|y_i=1|\theta)P(y_i=1|\theta) + P(x_i|y_i=0|\theta)P(y_i=0|\theta) 
}
-->

By replacing the known factors we get:

<img class="equation" src="img/eq58.png" height="42px" />
<!--
P(y_i=1|x_i,\theta) = 1 - P(y_i=0|x_i,\theta) = \frac{\phi_1(x_i, \mu_1, \sigma_1) \alpha}{
\phi_1(x_i, \mu_1, \sigma_1) \alpha + \phi_2(x_i, \mu_2, \sigma_2) (1 - \alpha)
}
-->

This is also called the responsibility of Model 1 (the first normal) for
observation 
<img class="inline-img" src="img/xi_small.png" />.
From now on, we will refer to this value as:

<img class="equation" src="img/eq59.png" height="21px" />
<!--
\tau_i = P(y_i=1|x_i,\theta)
-->

----

#### The Maximization Step

The maximization step consists of obtaining parameters such that:

<img class="equation" src="img/eq61.png" height="42px" />
<!--
\hat{\theta}^{(t+1)} = \argmax_{\theta} E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right]
-->

By replacing the responsibility in the expected log-likelihood, we get:

<img class="equation" src="img/eq60.png" height="42px" />
<!--
E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right] = 
\sum_{i=0}^N 
\tau_i \left[ \ln \alpha + \ln \phi_1(x_i, \mu_1, \sigma_1)       \right] + 
(1-\tau_i) \left[ \ln (1 - \alpha) + \ln \phi_2(x_i, \mu_2, \sigma_2) \right]
-->

__Partial Derivatives__

The partial derivatives for this expression are:

<img class="equation" src="img/eq62.png" height="42px" />
<!--
\frac{\partial E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right]}{\partial \alpha} =
\sum_{i=0}^N 
\frac{\tau_i}{\alpha} - \frac{1-\tau_i}{(1 - \alpha)}
-->

<img class="equation" src="img/eq63.png" height="42px" />
<!--
\frac{\partial E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right]}{\partial \mu_1} =
\frac{1}{\alpha}
\sum_{i=0}^N 
\tau_i \frac{(x_i - \mu_1)}{\sigma_1^2}
-->

<img class="equation" src="img/eq64.png" height="42px" />
<!--
\frac{\partial E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right]}{\partial \mu_2} =
\frac{1}{1 - \alpha}
\sum_{i=0}^N 
(1 - \tau_i) \frac{(x_i - \mu_2)}{\sigma_2^2}
-->

<img class="equation" src="img/eq65.png" height="42px" />
<!--
\frac{\partial E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right]}{\partial \sigma_1} =
\frac{1}{\alpha}
\sum_{i=0}^N 
\tau_i \frac{1}{\sigma_1} \left[ \left( \frac{(x_i - \mu_1)}{\sigma_1} \right)^2 - 1 \right] 
-->

<img class="equation" src="img/eq66.png" height="42px" />
<!--
\frac{\partial E_{y|x,\theta^{(t)}} \left[ \ell (\theta|x, y) \right]}{\partial \sigma_2} =
\frac{1}{1 - \alpha}
\sum_{i=0}^N 
(1 - \tau_i) \frac{1}{\sigma_2} \left[ \left( \frac{(x_i - \mu_2)}{\sigma_2} \right)^2 - 1 \right] 
-->

Next, we make all partial derivatives equal to zero to find the critical points.
Solving for
<img class="inline-img" src="img/alpha_small.png" /> we get:

<img class="equation" src="img/eq67.png" height="42px" />
<!--
\alpha \sum_{i=0}^N  1-\tau_i =
(1 - \alpha) \sum_{i=0}^N \tau_i 
-->

<img class="equation" src="img/eq68.png" height="42px" />
<!--
\alpha N - \alpha \sum_{i=0}^N  \tau_i =
\sum_{i=0}^N \tau_i - \alpha \sum_{i=0}^N \tau_i
-->

<img class="equation" src="img/eq69.png" height="42px" />
<!--
\alpha = \frac{\sum_{i=0}^N \tau_i}{N}
-->

Solving for
<img class="inline-img" src="img/mu1_small.png" /> and
<img class="inline-img" src="img/mu2_small.png" /> we get:

<img class="equation" src="img/eq70.png" height="42px" />
<!--
\sum_{i=0}^N \tau_i \frac{(x_i - \mu_1)}{\sigma_1^2} = 0
-->

<img class="equation" src="img/eq71.png" height="42px" />
<!--
\mu_1 \sum_{i=0}^N \tau_i = \sum_{i=0}^N \tau_i x_i 
-->

<img class="equation" src="img/eq72.png" height="42px" />
<!--
\mu_1 = \frac{\sum_{i=0}^N \tau_i x_i}{\sum_{i=0}^N \tau_i }
-->

And by symmetry:

<img class="equation" src="img/eq73.png" height="42px" />
<!--
\mu_2 = \frac{\sum_{i=0}^N (1 - \tau_i) x_i}{\sum_{i=0}^N (1 - \tau_i) }
-->

Solving 
<img class="inline-img" src="img/sigma1_small.png" /> and
<img class="inline-img" src="img/sigma2_small.png" /> we get:

<img class="equation" src="img/eq74.png" height="42px" />
<!--
\sum_{i=0}^N 
(1 - \tau_i) \frac{1}{\sigma_1} \left[ \left( \frac{(x_i - \mu_1)}{\sigma_1} \right)^2 - 1 \right] = 0
-->

<img class="equation" src="img/eq75.png" height="42px" />
<!--
\sigma_1^2 \sum_{i=0}^N \tau_i = \sum_{i=0}^N \tau_i \left( x_i - \mu_1 \right)^2
-->

<img class="equation" src="img/eq76.png" height="42px" />
<!--
\sigma_1^2 = \frac{\sum_{i=0}^N \tau_i \left( x_i - \mu_1 \right)^2}{\sum_{i=0}^N \tau_i}
-->

And by symmetry:

<img class="equation" src="img/eq77.png" height="42px" />
<!--
\sigma_2^2 = \frac{\sum_{i=0}^N (1 - \tau_i) \left( x_i - \mu_2 \right)^2}{\sum_{i=0}^N (1 - \tau_i)}
-->

-----

#### The EM Algorithm for the Gaussian Mixture Model:

With that, we have everything we need to run the EM algorithm:

##### (1) Expectation Step:

Compute the responsibilities:

<img class="equation" src="img/eq78.png" height="42px" />
<!--
\tau_i^{(t+1)} = \frac{\phi_1(x_i, \mu_1, \sigma_1) \; \alpha^{(t)}}{
\phi_1(x_i, \mu_1, \sigma_1) \; \alpha^{(t)} + \phi_2(x_i, \mu_2, \sigma_2) \; (1 - \alpha^{(t)})}
-->

##### (2) Maximization Step:

Maximize the expected log-likelihood by setting:

<img class="equation" src="img/eq79.png" height="42px" />
<!--
\alpha^{(t+1)} = \frac{\sum_{i=0}^N \tau_i^{(t+1)}}{N}
-->

<img class="equation" src="img/eq80.png" height="42px" />
<!--
\mu_1^{(t+1)} = \frac{\sum_{i=0}^N \tau_i^{(t+1)} x_i}{\sum_{i=0}^N \tau_i^{(t+1)} }
-->

<img class="equation" src="img/eq81.png" height="42px" />
<!--
\mu_2^{(t+1)} = \frac{\sum_{i=0}^N (1 - \tau_i^{(t+1)}) x_i}{\sum_{i=0}^N (1 - \tau_i^{(t+1)}) }
-->

<img class="equation" src="img/eq82.png" height="42px" />
<!--
\sigma_1^{(t+1)} = \sqrt{\frac{\sum_{i=0}^N \tau_i^{(t+1)} \left( x_i - \mu_1 \right)^2}{\sum_{i=0}^N \tau_i^{(t+1)}}}
-->

<img class="equation" src="img/eq83.png" height="42px" />
<!--
\sigma_2^{(t+1)} = \sqrt{\frac{\sum_{i=0}^N (1 - \tau_i^{(t+1)}) \left( x_i - \mu_2 \right)^2}{\sum_{i=0}^N (1 - \tau_i^{(t+1)})}}
-->

As you can see from the plot below, the algorithm converges quite quickly.

<img src="img/em_algorithm_mixtures.gif" />

We can also plot the responsibility to understand how it changes as we perform
more iterations. The responsibility tells us how sure we are about which 
distribution generated a given data point. This value could be used to detect
which points definitely belong to a given distribution and which points are
more ambiguous.

<img src="img/responsibility.gif" />

----

#### Gradient Ascent (optional)

This section shows a different approach to mixture model optimization using
Gradient Ascent. The purpose of this section is to show that there are 
alternatives to the EM Algorithm in some cases.

To run Gradient Ascent to optimize our Gaussian Mixture Model, we need only the 
first derivatives of:

<img class="equation" src="img/eq46.png" height="42px" />
<!--
\ell (\theta|x) = \sum_{i=0}^N \ln \bigg( \alpha \; \phi_1(x_i, \mu_1, \sigma_1) + 
(1 - \alpha) \; \phi_2(x_i, \mu_2, \sigma_2) \bigg)
-->

The first derivatives of the log-likelihood are:

<img class="equation" src="img/eq47.png" height="42px" />
<!--
\frac{\partial \ell (\theta|x)}{\partial \alpha} = \alpha \sum_{i=0}^N   
\frac{\phi_1(x_i, \mu_1, \sigma_1) - \phi_2(x_i, \mu_2, \sigma_2)}{f(x_i; \theta)} 
-->

<img class="equation" src="img/eq48.png" height="42px" />
<!--
\frac{\partial \ell (\theta|x)}{\partial \mu_1} = \alpha \sum_{i=0}^N   
\frac{x_i - \mu_1}{\sigma_1^2} 
\frac{\phi_1(x_i, \mu_1, \sigma_1)}{f(x_i; \theta)} 
</div>
-->

<img class="equation" src="img/eq49.png" height="42px" />
<!--
\frac{\partial \ell (\theta|x)}{\partial \sigma_1} = \alpha \sum_{i=0}^N   
\left[ \frac{1}{\sigma_1}
\left(\frac{x_i - \mu_1}{\sigma_1}\right)^2 - 1 \right]
\frac{\phi_1(x_i, \mu_1, \sigma_1)}{f(x_i; \theta)} 
</div>
-->

<img class="equation" src="img/eq50.png" height="42px" />
<!--
\frac{\partial \ell (\theta|x)}{\partial \mu_2} = (1 - \alpha) \sum_{i=0}^N   
\frac{x_i - \mu_2}{\sigma_2^2} 
\frac{\phi_2(x_i, \mu_2, \sigma_2)}{f(x_i; \theta)} 
</div>
-->

<img class="equation" src="img/eq51.png" height="42px" />
<!--
\frac{\partial \ell (\theta|x)}{\partial \sigma_2} = (1 - \alpha) \sum_{i=0}^N   
\left[ \frac{1}{\sigma_2}
\left(\frac{x_i - \mu_2}{\sigma_2}\right)^2 - 1 \right]
\frac{\phi_2(x_i, \mu_2, \sigma_2)}{f(x_i; \theta)} 
-->

Starting with a random set of parameters where:

- <img class="inline-img" src="img/alpha_small.png" /> = 0.3
- <img class="inline-img" src="img/mu1_small.png" /> = 1
- <img class="inline-img" src="img/sigma1_small.png" /> = 1
- <img class="inline-img" src="img/mu2_small.png" /> = 3
- <img class="inline-img" src="img/sigma2_small.png" /> = 1
- Learning Rate = 0.01

The model converges after around 170 iterations.

<img src="img/gradient_ascent.gif" />

With a learning rate of 1.0, we reach the goal faster at the expense of more
volatility.

<img src="img/quick_gradient_ascent.gif" />

----

## Conclusion

With this we conclude the explanation of the EM algorithm for a multinomial 
distribution and a Gaussian Mixture Model in 1-Dimension.

These toy problems are useful to understand how to frame a problem in a different 
light to use the EM algorithm, but they are not really "good" examples because
the new framing is somewhat more complex than what we started with.
In some cases this new framing may turn an impossible problem into something 
manageable. You need to have in mind that the EM algorithm is an 
optimization method. Being that, it is a useful tool to have on the toolshed,
but depending on the application, other methods may be better suited. 
