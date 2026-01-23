import extract_msg
import os

def estrai_allegati_msg(percorso_relativo_msg, nome_cartella_output):
    # 1. Risoluzione dei percorsi (Abspath rende il percorso 'reale' e completo)
    percorso_msg = os.path.abspath(percorso_relativo_msg)
    cartella_dest = os.path.abspath(nome_cartella_output)

    print(f"File sorgente: {percorso_msg}")
    print(f"Cartella destinazione: {cartella_dest}\n")

    if not os.path.exists(percorso_msg):
        print("Errore: Il file .msg specificato non esiste.")
        return

    # 2. Creazione della cartella
    if not os.path.exists(cartella_dest):
        os.makedirs(cartella_dest)
        print(f"Cartella creata: {cartella_dest}")

    try:
        msg = extract_msg.Message(percorso_msg)
        
        if not msg.attachments:
            print("Nessun allegato trovato.")
        else:
            for allegato in msg.attachments:
                # Salvataggio usando il percorso assoluto risolto
                allegato.save(customPath=cartella_dest)
                print(f"Estratto: {allegato.longFilename}")
        
        msg.close()
    except Exception as e:
        print(f"Si è verificato un errore: {e}")

# Esempio
estrai_allegati_msg("test.msg", "allegati_estratti")
