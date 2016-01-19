# handling large datasets, 49K predictors in R glmnet
data <- matrix(rep(0,50*49000), nrow=50)
#x = rep(letters[2:8], 7000)
for(i in 1:50) {
  #y = sample(x=1:49000, size=49000)
  #data[i,] <- sample(x)
  data[i,] <- sample(rep(letters[2:8], 7000))
}
dim(data)
data[1:5, 1:5]
x <- c(rep('A', 15), rep('B', 15), rep('C', 20))
class <- sample(x, 50)

#Fails on 4G RAM machine,: Error: cannot allocate vector of size 8.9 Gb 
#X <- model.matrix(class~., data = as.data.frame(data))
#try with spare.model.matrix
# Again fails with: Error: cannot allocate vector of size 8.9 Gb
#X.sparse <- sparse.model.matrix(class~., data = as.data.frame(data))

# http://www.r-bloggers.com/genetic-data-large-matrices-and-glmnet/
## Cria a matriz de entrada usando a primeira coluna
X <- sparse.model.matrix(~data[,1]-1)

## Verifica se a coluna tem mais de um nível (tipo factor naturalmente!)
for (i in 2:ncol(data)) {
  
  ## Se tiver mais de um nível aplica codificação dummy
  if (nlevels(data[,i])>1) {
    coluna <- sparse.model.matrix(~data[,i]-1)
    dim(coluna)
    X <- cBind(X, coluna)
    dim(X)
  }
  ## Se tiver um número transforma em factor e depois em numérico.
  else {
    coluna <- as.numeric(as.factor(data[,i]))
    X <- cBind(X, coluna)
  }
}
big.lasso <- cv.glmnet(X, class, standardize=F, 
                       family = 'multinomial', alpha =1, nfolds=3)