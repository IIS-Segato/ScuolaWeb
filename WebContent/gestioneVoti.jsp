<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <title>Gestione voti</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #eefaf6;
        }

        .table-container {
            margin-top: 40px;
        }

        #backPageBtn {
            display: inline-block;
            margin: 20px;
            padding: 10px 18px;
            background: #146c5c;
            color: white;
            border-radius: 10px;
            text-decoration: none;
        }
    </style>
</head>

<body>
<a id="backPageBtn" href="admin.html">← Indietro</a>

<div class="container mt-5">

    <!-- CARD INSERIMENTO -->
    <div class="card p-4 rounded-4 shadow">

        <h2 class="mb-4 text-success">
            Inserisci voto
        </h2>

        <form>

            <!-- STUDENTE -->
            <div class="mb-3">
                <label class="form-label">Studente</label>

                <input type="text"
                       class="form-control"
                       placeholder="Nome studente"
                       id="studentInput"
                       >
            </div>

            <!-- MATERIA -->
            <div class="mb-3">

                <label class="form-label">
                    Materia
                </label>

                <select class="form-select" id="subjInput">

                    <option selected disabled>
                        Seleziona materia
                    </option>

                    <option>Italiano</option>
                    <option>Matematica</option>
                    <option>Inglese</option>
                    <option>Storia</option>
                    <option>Informatica</option>

                </select>

            </div>

            <!-- VOTO -->
            <div class="mb-4">

                <label class="form-label">
                    Voto
                </label>

                <select class="form-select" id="gradInput">

                    <option selected disabled>
                        Seleziona voto
                    </option>

                    <option>2</option>
                    <option>2+</option>
                    <option>2½</option>

                    <option>3</option>
                    <option>3+</option>
                    <option>3½</option>

                    <option>4</option>
                    <option>4+</option>
                    <option>4½</option>

                    <option>5</option>
                    <option>5+</option>
                    <option>5½</option>

                    <option>6</option>
                    <option>6+</option>
                    <option>6½</option>

                    <option>7</option>
                    <option>7+</option>
                    <option>7½</option>

                    <option>8</option>
                    <option>8+</option>
                    <option>8½</option>

                    <option>9</option>
                    <option>9+</option>
                    <option>9½</option>

                    <option>10</option>

                </select>

            </div>

            <button class="btn btn-success">
                Salva voto
            </button>

        </form>

    </div>

    <!-- TABELLA VOTI -->
    <div class="table-container">

        <div class="card p-4 rounded-4 shadow">

            <h3 class="mb-4">
                Voti inseriti
            </h3>

            <table class="table table-hover align-middle">

                <thead class="table-success">

                    <tr>
                        <th>Studente</th>
                        <th>Materia</th>
                        <th>Voto</th>
                        <th>Azioni</th>
                    </tr>

                </thead>

                <tbody>

                    <tr>
                        <td>Mario Rossi</td>
                        <td>Matematica</td>
                        <td>8+</td>

                        <td>
                            <button class="btn btn-danger btn-sm">
                                Elimina
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <td>Luca Bianchi</td>
                        <td>Inglese</td>
                        <td>6½</td>

                        <td>
                            <button class="btn btn-danger btn-sm">
                                Elimina
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <td>Anna Verdi</td>
                        <td>Italiano</td>
                        <td>9</td>

                        <td>
                            <button class="btn btn-danger btn-sm">
                                Elimina
                            </button>
                        </td>
                    </tr>

                </tbody>

            </table>

        </div>

    </div>

</div>

<script>
    const input = document.getElementById('studentInput');
    let timer;
    input.addEventListener('input', (e) => {
        const subj = document.getElementById('subjInput');
        const grad = document.getElementById('gradInput');
        clearTimeout(timer);

        timer = setTimeout(() => {
            console.log(subj.value);
            console.log(grad.value);
            console.log(e.target.value);
        }, 500);
    })
</script>

</body>
</html>