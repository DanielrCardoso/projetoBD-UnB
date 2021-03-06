from re import S
from flask.sessions import NullSession
from flask_mysqldb import MySQL
from config import config
from flask import render_template
from flask import Flask
from flask import request,session,url_for,redirect,send_from_directory
from markupsafe import escape
from datetime import timedelta
from flask_cors import CORS 

import crud

app = Flask(__name__, static_url_path='/static')
app.secret_key = "test"
app.permanent_session_lifetime = timedelta(minutes=5)
CORS(app) 
app.config["SESSION_PERMANENT"] = True
cmx = MySQL(app)
import crud

headers = {
    "table_user": ("id", "nome", "user", "senha", "on/off", "email", "blob"),
    "table_admin": ("id", "nome", "user", "senha", "on/off", "email", "blob")
}



# @app.route("/")
# def helloworld():
#     return "Hello, cross-origin-world"
@app.errorhandler(404)
def page_not_found(e):
    return render_template("my404.html")

@app.route("/logout")
def logout():
    session.pop("User", None)
    session.pop("Jogo", None)
    return redirect(url_for("login"))

@app.route("/logoutG")
def logoutG():
    session.pop("Jogo", None)
    return redirect(url_for("login"))

@app.route("/logoutA")
def logoutA():
    session.pop("User", None)
    session.pop("Admin", None)
    return redirect(url_for("login"))

@app.route("/home",methods=["GET","POST"])
def login():
    if  'User' in session:
        return redirect(url_for("telaUser"))
    if request.method == "POST":
        try:
            nomeUser = request.form.get("nomeUser")
            senhaUser = request.form.get("senhaUser")
            senha = crud.seleciona_um(nomeUser,"senha","usuario", "user")
            print("senha",senha)
            print("senhaUser",senhaUser)
            if senha == ():
                print("usuario não encontrado!")
                return  render_template("TelaR.html", data="usuario não encontrado!")
            elif senha!= None and senha[0][0] == senhaUser and nomeUser!=None:
                session["User"] = nomeUser
                return redirect(url_for("telaUser"))
            else:
                print("senha invalida")
                return  render_template("TelaR.html", data="Senha invalida!")
        except Exception as ax:
            print(ax)
    return  render_template("TelaLogin.html")

@app.route("/telaUser",methods=["GET","POST"])
def telaUser():
    if  'User' in session:
        if 'Admin' in session:
            return redirect(url_for("loginAdm"))
        if 'Jogo' in session:
            data = crud.seleciona_um(session["User"],"*","usuario","user")  
            typeP = request.form.get("btnP")
            dataP = request.form.get("pesq")
            print("tp:",typeP)  ## verificar
            if dataP != "" and typeP == "Conta":
                try:
                    dataP = crud.seleciona_um(dataP,"*","usuario","user")
                    if dataP != ():
                        return  render_template("TelaUser.html", sess=session['User'],jog=session['Jogo'], data = dataP, flag = "False")
                    return  render_template("TelaUser.html", sess=session['User'],jog=session['Jogo'], data = data, flag = "True")
                except Exception as ax:
                    print("exceção=" , ax)
            if dataP != "" and typeP == "Partida":
                print("Partidasssa:")
            return  render_template("TelaUser.html", sess=session['User'],jog=session['Jogo'], data = data, flag = "False")
        game = request.form.get("jogo")
        id_user = crud.seleciona_um(session["User"],"IDusuario","usuario","user")

        # print(crud.seleciona_um(id_user[0][0],"*","Biblioteca","id_usuario"))
        jogosnabib = crud.seleciona_um(id_user[0][0],"*","Biblioteca","id_usuario")
        print("jogo:", jogosnabib)
        if game != None:    
            session["Jogo"] = crud.seleciona_um(game,"nome_jogo","jogo","IDjogo")[0][0]
            return redirect(url_for("telaUser"))
        
        return  render_template("TelaJogos.html",data = jogosnabib)
    return redirect(url_for("login"))

@app.route("/CadastroAdmin",methods=["GET","POST"])
def CadastroAdmin():
    if request.method == "POST":
        acessKey = request.form.get("acessKey")
        if acessKey.find(":")==-1 or acessKey == ":":
            print("formato invalido")
        else:
            id = acessKey.split(":")
            chave = crud.seleciona_um(id[0],"chave")
            if id == None or chave == ():
               print("chave sem correspondencia")
            elif chave[0][0] == id[1]:
                val = crud.atualiza('administrador',(request.form.get("nomeUser"),request.form.get("nomeComp"),request.form.get("senha"),request.form.get("email")),id[0])
                print(val)
                return redirect(url_for("loginAdm")) if val[0] == 200 else render_template("CadastroAdmin.html")
            else:
                print("chave não aceita!")
    return  render_template("CadastroAdmin.html")

@app.route("/loginAdm",methods=["GET","POST"])
def loginAdm():
    if 'Admin' in session:
        print("Redirect for telaAdm by login")
        return redirect(url_for("telaAdm"))
    if request.method == "POST":
        try:
            nomeUser = request.form.get("nomeUser")
            senhaUser = request.form.get("senhaUser")
            senha = crud.seleciona_um(nomeUser,"senha","administrador", "user")
            if senha == ():
                print("usuario não encontrado!")  #retirar 
                return  render_template("LoginAdm.html", flag = "True")
            elif senha!= None and senha[0][0] == senhaUser and nomeUser!=None:
                print("entro")
                session["User"] = nomeUser
                session["Admin"] = nomeUser
                return redirect(url_for("telaAdm"))
            else:
                print("senha invalida")   #retirar 
                return  render_template("LoginAdm.html",  flag = "True")

        except Exception as ax:
            print(ax)
    return  render_template("LoginAdm.html", flag="False")

@app.route("/telaAdm")
def telaAdm():
    if 'Admin' in session:
        return  render_template("TelaAdmin.html", sess=session['Admin'])
    return redirect(url_for("login"))


@app.route("/CadastroUsuario",methods=["GET","POST"])
def CadastroUsuario():
    if request.method == "POST":
        try:
            alerta = crud.adiciona("usuario",(request.form.get("nomeUser"), request.form.get("nomeComp"), request.form.get("senha"), request.form.get("email")))
            print("alerta:",alerta)
            if alerta[0] == 200:
                print("entrou")
                return redirect(url_for("login"))
        except Exception as ax:
            print(ax)
    return  render_template("CadastroUsuario.html")

@app.route("/CadastroJogo",methods=["GET","POST"])
def CadastroJogo():
    flImage = request.form.get("flImage")
    inputNomeJogo = request.form.get("inputNomeJogo")
    classificacao_indicativa = request.form.get("classificacao_indicativa")
    inputNomeDesenvolvedora = request.form.get("inputNomeDesenvolvedora")
    inputCategoria = request.form.get("inputCategoria")
    inputDataDelancamento = request.form.get("inputDataDelancamento")
    inputsinopse = request.form.get("inputsinopse")

    
    crud.adiciona("jogo",(inputNomeJogo, inputNomeDesenvolvedora, classificacao_indicativa, inputCategoria, inputsinopse, inputDataDelancamento,"1"))
    return  render_template("CadastroJogo.html")

@app.route("/pb",methods=["GET","POST"])
def pbt():
    return  render_template("pb.html")

@app.route("/load/<tabela>",methods=["GET","POST"]) 
def load(tabela): 
    # print("tabela:",tabela)  # retirar
    headings = headers[tabela]
    aux = "usuario" if tabela =="table_user" else "administrador"
    data = crud.seleciona_todos(aux)
    # print(aux)  # retirar
    # print(data)  # retirar
    return  render_template("/tabelasAdm/" + tabela +  ".html",data=data, headings=headings, user=aux)


@app.route('/js/<path:path>')
def send_js(path):
    print("1")
    return send_from_directory('js', path)

@app.route("/simula")
def simula():
    # crud.adiciona("usuario",)
    return  render_template("/tabelasAdm/" + tabela +  ".html",data=data, headings=headings, user=aux)

@app.route("/editandojogos")
def editandojogos():
    flImage = request.form.get("flImage")
    inputNomeJogo = request.form.get("inputNomeJogo")

    crud.exclui("exclui",inputNomeJogo,"IDjogo")
    return render_template("editjogo.html")

@app.route("/Telaeditar")
def Telaeditar():
    data = ["a","b"]
    return render_template("Telaeditar.html",data = data)

if __name__ == "__main__":
    app.config.from_object(config["gabconfig"])
    app.run()
    