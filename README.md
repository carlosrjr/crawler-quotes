# Crawler Quotes

Este crawler faz o scrape em <a>http://quotes.toscrape.com</a> para obter frases a partir de tags informadas na consulta.

## 1. Tecnologias Utilizadas

Para desenvolver esta solução, foi utilizado:

- Ruby 2.7.3p183
- Rails 5.0.7.2
- Mongodb 4.2.15

## 2. API Endpoints

<table>
  <thead>
    <tr>
      <td><strong>HTTP Method</strong></td>
      <td><strong>Description</strong></td>
      <td><strong>Path</strong></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>POST</td>
      <td>Cria um novo usuário.</td>
      <td>/auth/sigup</td>
    </tr>
    <tr>
      <td>POST</td>
      <td>Realiza o login de um usuário cadastrado para obter um token de acesso.</td>
      <td>/auth/sigin</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>Lista todos os quotes armazenos no bando de dados.</td>
      <td>/quotes</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>Lista os quotes filtrando pela tag. Se a tag ainda não existir no banco, faz o scrape.</td>
      <td>/quotes/:tag</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>Lista todas as tags cadastradas no banco de dados.</td>
      <td>/tags</td>
    </tr>
    <tr>
      <td>GET</td>
      <td>Exibe uma tag cadastrada no banco de dados, caso ela exista.</td>
      <td>/tags/:tag</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>Remove uma tag que esteja registrada no banco de dados.</td>
      <td>/tags/:tag</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>Limpa todos os quotes e tags cadastrados no banco de dados.</td>
      <td>/clean/quotes</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>Limpa todas as tags cadastradas no banco de dados.</td>
      <td>/clean/tags</td>
    </tr>
    <tr>
      <td>DELETE</td>
      <td>Remove um usuário cadastrado.</td>
      <td>/auth/remove</td>
    </tr>
  </tbody>
</table>

## 3. Autenticação

Para utilizar os endpoints, é necessário possuir um usuário cadastrado para realizar login e obter o token **JWT** para que o acesso seja permitido. 

### Endpoint: /auth/signup

Para cadastrar um usuário, deve informar um **username** e um **password** no formato **JSON** na requisição.

#### Request

```json
{
  "username": "administrador",
  "password": "123456"
}
```

#### Response

```json
{
  "success": "Usuário criado com sucesso."
}
```

#### Errors

Quando já existe um usuário com o mesmo **username** cadastrado:

```json
{
  "status_code": 400,
  "message": "Usuário já existe."
}
```

Quando o **username** ou **password** possuem menos de 6 caracteres:

```json
{
  "status_code": 401,
  "message": "Os campos 'username' e 'password' devem ter no mínimo 6 caracteres."
}
```

### Endpoint: /auth/signin

Para realizar o login de um usuário, deve informar um **username** e um **password** no formato **JSON** na requisição.

#### Request

```json
{
  "username": "administrador",
  "password": "123456"
}
```

#### Response

```json
{
  "username": "administrador",
  "jwt": {
    "prefix": "Bearer",
    "encodedToken": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImFkbWluaXN0cmFkb3IiLCJkYXRlX2FjY2VzcyI6IjIwMjEtMDktMDZUMjE6NDM6MjItMDM6MDAifQ.e59ZQ0_18bUPsuLkMaXBZ96LN_mJ7OvPw7ukyHNc3N0",
    "date_access": "2021-09-06T21:43:22.677-03:00"
  }
}
```

#### Errors

Quando o **username** ou **password** são inválidos:

```json
{
  "status_code": 401,
  "message": "Acesso não autorizado."
}
```