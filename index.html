<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sistema de Rotas de Transporte</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial;
    }

    body {
      background: #eef3f7;
    }

    header {
      background: #1565C0;
      color: white;
      padding: 20px;
      text-align: center;
    }

    .container {
      width: 95%;
      max-width: 1200px;
      margin: auto;
      margin-top: 20px;
    }

    .card {
      background: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.2);
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 15px;
    }

    label {
      font-weight: bold;
      display: block;
      margin-top: 10px;
    }

    input {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    button {
      padding: 12px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 15px;
    }

    .salvar {
      background: #2E7D32;
      color: white;
    }

    .editar {
      background: #FB8C00;
      color: white;
    }

    .excluir {
      background: #C62828;
      color: white;
    }

    table {
      width: 100%;
      margin-top: 20px;
      border-collapse: collapse;
    }

    th {
      background: #1565C0;
      color: white;
      padding: 10px;
    }

    td {
      padding: 10px;
      border-bottom: 1px solid #ddd;
    }

    tr:hover {
      background: #f5f5f5;
    }

    #pesquisa {
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
  <header>
    <h1>Sistema de Rotas de Transporte</h1>
  </header>

  <div class="container">
    <div class="card">
      <div class="grid">
        <div>
          <label>Rota</label>
          <input id="rota">
        </div>
        <div>
          <label>Motorista</label>
          <input id="motorista">
        </div>
        <div>
          <label>Veículo</label>
          <input id="veiculo">
        </div>
        <div>
          <label>Saída</label>
          <input type="time" id="hora">
        </div>
        <div>
          <label>Parada 1</label>
          <input id="p1">
        </div>
        <div>
          <label>Parada 2</label>
          <input id="p2">
        </div>
        <div>
          <label>Parada 3</label>
          <input id="p3">
        </div>
        <div>
          <label>Destino</label>
          <input id="destino">
        </div>
      </div>
      <br>
      <button class="salvar" onclick="salvar()">Salvar Rota</button>
    </div>

    <br>

    <div class="card">
      <input id="pesquisa" placeholder="Pesquisar..." onkeyup="listar()">
      <table>
        <thead>
          <tr>
            <th>Rota</th>
            <th>Motorista</th>
            <th>Veículo</th>
            <th>Horário</th>
            <th>Percurso</th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody id="tabela">
        </tbody>
      </table>
    </div>
  </div>

  <script>
    let rotas = JSON.parse(localStorage.getItem("rotas")) || [];
    let editarIndice = -1;

    function salvar() {
      let rota = document.getElementById("rota").value;
      let motorista = document.getElementById("motorista").value;
      let veiculo = document.getElementById("veiculo").value;
      let hora = document.getElementById("hora").value;
      let p1 = document.getElementById("p1").value;
      let p2 = document.getElementById("p2").value;
      let p3 = document.getElementById("p3").value;
      let destino = document.getElementById("destino").value;

      let dados = {
        rota, motorista, veiculo, hora, p1, p2, p3, destino
      };

      if (editarIndice == -1) {
        rotas.push(dados);
      } else {
        rotas[editarIndice] = dados;
        editarIndice = -1;
      }

      localStorage.setItem("rotas", JSON.stringify(rotas));
      limpar();
      listar();
    }

    function listar() {
      let texto = document.getElementById("pesquisa").value.toLowerCase();
      let tabela = document.getElementById("tabela");
      tabela.innerHTML = "";

      rotas.forEach((r, i) => {
        let busca = (r.rota + r.motorista + r.veiculo + r.destino).toLowerCase();
        if (busca.includes(texto)) {
          tabela.innerHTML += `
            <tr>
              <td>${r.rota}</td>
              <td>${r.motorista}</td>
              <td>${r.veiculo}</td>
              <td>${r.hora}</td>
              <td>
                ${r.p1} &rarr; ${r.p2} &rarr; ${r.p3} &rarr; ${r.destino}
              </td>
              <td>
                <button class="editar" onclick="editar(${i})">Editar</button>
                <button class="excluir" onclick="excluir(${i})">Excluir</button>
              </td>
            </tr>
          `;
        }
      });
    }

    function editar(i) {
      let r = rotas[i];
      document.getElementById("rota").value = r.rota;
      document.getElementById("motorista").value = r.motorista;
      document.getElementById("veiculo").value = r.veiculo;
      document.getElementById("hora").value = r.hora;
      document.getElementById("p1").value = r.p1;
      document.getElementById("p2").value = r.p2;
      document.getElementById("p3").value = r.p3;
      document.getElementById("destino").value = r.destino;
      editarIndice = i;
    }

    function excluir(i) {
      if (confirm("Excluir rota?")) {
        rotas.splice(i, 1);
        localStorage.setItem("rotas", JSON.stringify(rotas));
        listar();
      }
    }

    function limpar() {
      document.querySelectorAll("input").forEach(c => {
        if (c.type !== "search") {
          c.value = "";
        }
      });
    }

    listar();
  </script>
</body>
</html>
