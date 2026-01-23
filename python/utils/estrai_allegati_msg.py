import extract_msg
import os
from tqdm import tqdm

def processa_cartella_msg(cartella_input, cartella_output):
    # Risoluzione percorsi assoluti
    input_abs = os.path.abspath(cartella_input)
    output_abs = os.path.abspath(cartella_output)

    # Recupera la lista di tutti i file .msg nella cartella
    files_msg = [f for f in os.listdir(input_abs) if f.lower().endswith('.msg')]

    if not files_msg:
        print(f"Nessun file .msg trovato in {input_abs}")
        return

    # Crea la cartella di output se non esiste
    os.makedirs(output_abs, exist_ok=True)

    print(f"Trovati {len(files_msg)} file. Inizio estrazione...\n")

    # Inizializza la barra di progressione
    for nome_file in tqdm(files_msg, desc="Estrazione allegati", unit="mail"):
        percorso_completo_msg = os.path.join(input_abs, nome_file)
        
        try:
            msg = extract_msg.Message(percorso_completo_msg)
            
            # Se ci sono allegati, li salviamo in una sottocartella dedicata 
            # col nome della mail per non mischiare tutto
            if msg.attachments:
                sottocartella_mail = os.path.join(output_abs, nome_file.replace(".msg", ""))
                os.makedirs(sottocartella_mail, exist_ok=True)
                
                for allegato in msg.attachments:
                    allegato.save(customPath=sottocartella_mail)
            
            msg.close()
        except Exception as e:
            # Stampiamo l'errore senza interrompere il ciclo per gli altri file
            print(f"\n[ERRORE] Impossibile processare {nome_file}: {e}")

    print(f"\nLavoro terminato! Trovi tutto in: {output_abs}")

# --- ESEMPIO D'USO ---
cartella_sorgente = "./archivio_mail"  # Dove hai i tuoi .msg
cartella_destinazione = "./output_allegati"

processa_cartella_msg(cartella_sorgente, cartella_destinazione)