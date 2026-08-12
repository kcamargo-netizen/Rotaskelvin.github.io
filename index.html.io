<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sistema de Rotas de Transporte</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
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
      margin-bottom: 20px;
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

    .mapa-btn {
      background: #6A1B9A;
      color: white;
      margin-top: 6px;
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
      vertical-align: top;
    }

    tr:hover {
      background: #f5f5f5;
    }

    #pesquisa {
      margin-bottom: 20px;
    }

    .tempo-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
      gap: 12px;
      margin-top: 15px;
      background: #f8f9fa;
      padding: 15px;
      border-radius: 8px;
    }

    .timeline {
      margin-top: 15px;
      padding: 12px;
      background: #e3f2fd;
      border-radius: 8px;
      border-left: 4px solid #1565C0;
      font-size: 14px;
    }

    #map {
      height: 320px;
      width: 100%;
      border-radius: 8px;
      margin-top: 10px;
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
          <input type="time" id="hora" onchange="atualizarTimeline()">
        </div>
        <div>
          <label>Parada 1</label>
          <input id="p1" onchange="atualizarTimeline()">
        </div>
        <div>
          <label>Parada 2</label>
          <input id="p2" onchange="atualizarTimeline()">
        </div>
        <div>
          <label>Parada 3</label>
          <input id="p3" onchange="atualizarTimeline()">
        </div>
        <div>
          <label>Destino</label>
          <input id="destino" onchange="atualizarTimeline()">
        </div>
      </div>

      <div class="tempo-grid">
        <div>
          <label>Minutos até Parada 1</label>
          <input type="number" id="t1" min="0" value="10" onchange="atualizarTimeline()">
        </div>
        <div>
          <label>Minutos até Parada 2</label>
          <input type="number" id="t2" min="0" value="15" onchange="atualizarTimeline()">
        </div>
        <div>
          <label>Minutos até Parada 3</label>
          <input type="number" id="t3" min="0" value="15" onchange="atualizarTimeline()">
        </div>
        <div>
          <label>Minutos até Destino</label>
          <input type="number" id="t4" min="0" value="20" onchange="atualizarTimeline()">
        </div>
      </div>

      <div class="timeline" id="timeline">
        Informe o horário de saída e os tempos de deslocamento.
      </div>

      <br>
      <button class="salvar" onclick="salvar()">Salvar Rota</button>
    </div>

    <div class="card">
      <h3 style="margin-bottom:10px; color:#1565C0;">Mapa</h3>
      <div id="map"></div>
    </div>

    <div class="card">
      <input id="pesquisa" placeholder="Pesquisar..." onkeyup="listar()">
      <table>
        <thead>
          <tr>
            <th>Rota</th>
            <th>Motorista</th>
            <th>Veículo</th>
            <th>Horário</th>
            <th>Percurso + Chegadas</th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody id="tabela">
        </tbody>
      </table>
    </div>
  </div>

  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
  <script>
    let rotas = JSON.parse(localStorage.getItem("rotas")) || [];
    let editarIndice = -1;

    const map = L.map('map').setView([-15.7801, -47.9292], 4);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap'
    }).addTo(map);

    function atualizarTimeline() {
      const hora = document.getElementById("hora").value;
      const p1 = document.getElementById("p1").value || "Parada 1";
      const p2 = document.getElementById("p2").value || "Parada 2";
      const p3 = document.getElementById("p3").value || "Parada 3";
      const destino = document.getElementById("destino").value || "Destino";
      const t1 = Number(document.getElementById("t1").value) || 0;
      const t2 = Number(document.getElementById("t2").value) || 0;
      const t3 = Number(document.getElementById("t3").value) || 0;
      const t4 = Number(document.getElementById("t4").value) || 0;

      if (!hora) {
        document.getElementById("timeline").innerHTML = "Informe o horário de saída e os tempos de deslocamento.";
        return;
      }

      let atual = new Date(`2000-01-01T${hora}`);
      let html = `<strong>Horários:</strong><br>`;
      html += `Saída: <strong>${hora}</strong><br>`;

      atual.setMinutes(atual.getMinutes() + t1);
      html += `Chegada ${p1}: <strong>${atual.toTimeString().slice(0,5)}</strong><br>`;

      atual.setMinutes(atual.getMinutes() + t2);
      html += `Chegada ${p2}: <strong>${atual.toTimeString().slice(0,5)}</strong><br>`;

      atual.setMinutes(atual.getMinutes() + t3);
      html += `Chegada ${p3}: <strong>${atual.toTimeString().slice(0,5)}</strong><br>`;

      atual.setMinutes(atual.getMinutes() + t4);
      html += `Chegada ${destino}: <strong>${atual.toTimeString().slice(0,5)}</strong>`;

      document.getElementById("timeline").innerHTML = html;
    }

    function salvar() {
      let rota = document.getElementById("rota").value;
      let motorista = document.getElementById("motorista").value;
      let veiculo = document.getElementById("veiculo").value;
      let hora = document.getElementById("hora").value;
      let p1 = document.getElementById("p1").value;
      let p2 = document.getElementById("p2").value;
      let p3 = document.getElementById("p3").value;
      let destino = document.getElementById("destino").value;
      let t1 = Number(document.getElementById("t1").value) || 0;
      let t2 = Number(document.getElementById("t2").value) || 0;
      let t3 = Number(document.getElementById("t3").value) || 0;
      let t4 = Number(document.getElementById("t4").value) || 0;

      let dados = {
        rota, motorista, veiculo, hora, p1, p2, p3, destino, t1, t2, t3, t4
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

          let atual = new Date(`2000-01-01T${r.hora}`);
          let chegadas = "";

          atual.setMinutes(atual.getMinutes() + (r.t1 || 0));
          chegadas += `${r.p1} (${atual.toTimeString().slice(0,5)}) → `;

          atual.setMinutes(atual.getMinutes() + (r.t2 || 0));
          chegadas += `${r.p2} (${atual.toTimeString().slice(0,5)}) → `;

          atual.setMinutes(atual.getMinutes() + (r.t3 || 0));
          chegadas += `${r.p3} (${atual.toTimeString().slice(0,5)}) → `;

          atual.setMinutes(atual.getMinutes() + (r.t4 || 0));
          chegadas += `${r.destino} (${atual.toTimeString().slice(0,5)})`;

          const pontos = [r.p1, r.p2, r.p3, r.destino]
            .filter(p => p && p.trim() !== "")
            .map(p => encodeURIComponent(p))
            .join("/");
          const mapsUrl = `https://www.google.com/maps/dir/${pontos}`;

          tabela.innerHTML += `
            <tr>
              <td>${r.rota}</td>
              <td>${r.motorista}</td>
              <td>${r.veiculo}</td>
              <td>${r.hora}</td>
              <td>${chegadas}</td>
              <td>
                <button class="editar" onclick="editar(${i})">Editar</button>
                <button class="excluir" onclick="excluir(${i})">Excluir</button>
                <br>
                <a href="${mapsUrl}" target="_blank">
                  <button class="mapa-btn">Abrir no Google Maps</button>
                </a>
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
      document.getElementById("t1").value = r.t1 || 10;
      document.getElementById("t2").value = r.t2 || 15;
      document.getElementById("t3").value = r.t3 || 15;
      document.getElementById("t4").value = r.t4 || 20;
      editarIndice = i;
      atualizarTimeline();
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
        if (c.type !== "search" && c.id !== "t1" && c.id !== "t2" && c.id !== "t3" && c.id !== "t4") {
          c.value = "";
        }
      });
      document.getElementById("t1").value = 10;
      document.getElementById("t2").value = 15;
      document.getElementById("t3").value = 15;
      document.getElementById("t4").value = 20;
      document.getElementById("timeline").innerHTML = "Informe o horário de saída e os tempos de deslocamento.";
    }

    listar();
  </script>
</body>
</html>
