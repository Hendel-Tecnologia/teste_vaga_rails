# Projeto ProductManager

O objetivo deste mini projeto é implementar tarefas adicionais à api restfull deste repositório, que consiste em gerenciar o catálogo de produtos de um e-commerce.

### Tarefas:
1. Adicionar paginação a api de produtos
com o valor padrão de 20 itens por página, podendo ser alterado via parâmetros até o máximo de 100

2. Permitir ordenar por qualquer uma das colunas de forma crescente ou decrescente

3. Permitir filtrar por qualquer uma das colunas, podendo usar todas as comparações possíveis (contém, igual, diferente, maior, maior ou igual, menor...)

4. Criar api de produtos relacionados, em uma relação de n..n, onde um produto pode ter um ou mais produtos relacionados, sendo necessário validar que um produto não pode ser linkado a ele próprio. a api permitirá adicionar e remover relações de produtos

   `POST /products/:product_id/related_products`
   ```json
   // request body
   {
     "related_product_id": 22
   }
   ```

   ```json
   // response body, status: 201
   {
     "id": 22,
     "name": "Product test",
     "price": "10.99"
   }
   ```

   ```json
   // response body, status: 404|422
   {
     "errors": ["Mensagem de erro"]
   }
   ```

   `DELETE /products/:product_id/related_products/:related_product_id`

   ```json
   // response body, status: 204
   null
   ```

   ```json
   // response body, status: 404
   {
     "errors": ["Mensagem de erro"]
   }
   ```
5. Adicionar produtos relacionados ao json do produto apenas no endpoint de detalhes do produto, ficando no formato abaixo:
   ```json
    // response body, status: 200
    {
      "id": 1,
      "name": "Product test",
      "description": "Description of product test",
      "price": "10.99",
      "quantity": 50,
      "created_at": "2021-07-05T23:13:17.383Z",
      "created_at": "2021-07-05T23:13:17.383Z",
      "related_prooducts": [
        {
          "id": 22,
          "name": "Product test",
          "price": "10.99"
        }
      ]
    }

6. Atualizar a documentação com as alterações nos endpoints existentes e os novos

OBS:
- Nas tarefas 2 e 3 pode ser usado uma gem para facilitar o trabalho
- Já existem specs para o código atual, o candidato deverá adaptalas as mudanças solicitadas e adicionar novas quando necessário.

### O que já está pronto:
A api de produtos conforme a [documentação abaixo](#api-documentation)

## Rodando o projeto:

Requisitos:
  - Ruby 3.0.1
  - Rails 6.1.4
  - Postgresql

Comandos:

```bash
git clone https://github.com/Hendel-Tecnologia/teste_vaga_rails.git
```

```bash
cd teste_vaga_rails
```

```bash
bundle install
```

```bash
rails db:create db:migrate db:seed && RAILS_ENV=test rails db:migrate
```

Rodando os testes:
```bash
rspec -f doc
```

**OBS: Após finalizado o teste, o candidato deverá subir o projeto em seu github e nos enviar o link**

## API Documentation
- Product
  - [list](#list-products)
  - [get details](#get-product-details)
  - [create](#create-a-product)
  - [update](#update-a-product)
  - [delete](#delete-a-product)

### List Products
```
GET /products
```

```json
// response body, status: 200
[
  {
    "id": 1,
    "name": "Product test",
    "description": "Description of product test",
    "price": "10.99",
    "quantity": 50,
    "created_at": "2021-07-05T23:13:17.383Z",
    "created_at": "2021-07-05T23:13:17.383Z"
  }
]
```

### Get Product details
```
GET /products/:id
```

```json
// response body, status: 200
{
  "id": 1,
  "name": "Product test",
  "description": "Description of product test",
  "price": "10.99",
  "quantity": 50,
  "created_at": "2021-07-05T23:13:17.383Z",
  "created_at": "2021-07-05T23:13:17.383Z"
}
```

```json
// response body, status: 404
{
  "errors": ["Couldn't find Product with 'id'=22"]
}
```

### Create a Product
```
POST /products
```

```json
// request body
{
  "name": "Product test",
  "description": "Description of product test",
  "price": "10.99",
  "quantity": 50,
}
```

```json
// response body, status: 201
{
  "id": 1,
  "name": "Product test",
  "description": "Description of product test",
  "price": "10.99",
  "quantity": 50,
  "created_at": "2021-07-05T23:13:17.383Z",
  "created_at": "2021-07-05T23:13:17.383Z"
}
```

```json
// response body, status: 422
{
  "errors": ["Name has already been taken"]
}
```

### Update a Product
```
PUT/PATCH /products
```

```json
// request body
{
  "description": "NEW Description of product test",
}
```

```json
// response body, status: 201
{
  "id": 1,
  "name": "Product test",
  "description": "NEW Description of product test",
  "price": "10.99",
  "quantity": 50,
  "created_at": "2021-07-05T23:13:17.383Z",
  "created_at": "2021-07-05T23:13:17.383Z"
}
```

```json
// response body, status: 422
{
  "errors": ["Description can't be blank"]
}
```

### Delete a Product

```
DELETE /products/:id
```

```json
// response body, status: 204
null
```

```json
// response body, status: 404
{
  "errors": ["Couldn't find Product with 'id'=22"]
}
```
