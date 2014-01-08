model_code = {
'data {'
'int<lower=2> K;'
'int<lower=1> D;'
'}'
'parameters {'
'matrix[K,D] beta;'
'}'
'model {'
'for (k in 1:K)'
'    for (d in 1:D)'
'       beta[k,d] ~ normal(if_else(d==2,100, 0),1);'
'}'
};

model = stan('model_code',model_code,...
   'file_overwrite',true);



fit = model.sampling('data',struct('K',3,'D',4));
beta = fit.extract().beta;
assertEqual(size(beta),[4000 3 4]);
beta_mean = mean(beta,1);
assertTrue(all(beta_mean(:,1,1) < 4),'Should be < 4 on this dimension');