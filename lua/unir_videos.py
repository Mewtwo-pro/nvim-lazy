import os
import glob
import subprocess
import json
import re
# Ruta de la carpeta
folder_path = os.path.expanduser("~/.config/nvim/lua/video/")
pref_entrada_audio = "video_pre_"
# Función para ordenar de forma natural (reconoce números dentro del texto)
def natural_sort_key(s):
    return [int(text) if text.isdigit() else text.lower() for text in re.split(r'(\d+)', s)]


processed_parts = sorted(
    glob.glob(os.path.join(folder_path, f"{pref_entrada_audio}*.mp4")),
    key=natural_sort_key
)

name_video_final = "video_final.mp4"
def get_duration(file_path):
    """Obtiene la duración exacta en segundos usando ffprobe."""
    try:
        cmd = [
            "ffprobe", "-v", "quiet", "-show_format", 
            "-print_format", "json", file_path
        ]
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True)
        data = json.loads(result.stdout)
        return float(data["format"]["duration"])
    except Exception as e:
        print(f"Error obteniendo duración de {file_path}: {e}")
        return 0.0

def extract_index(filepath):
    """Extrae el número del archivo para ordenarlo numéricamente (1, 2, 3...)."""
    basename = os.path.basename(filepath)
    digits = "".join(filter(str.isdigit, basename))
    return int(digits) if digits else 0
# Paso final: Unir todas las partes generadas en un solo video maestro
    
if processed_parts:
    list_file_path = os.path.join(folder_path, "concat_list.txt")
    final_output_path = os.path.join(folder_path, name_video_final) 
    
    with open(list_file_path, "w") as f:
        for part in processed_parts:
            f.write(f"file '{os.path.basename(part)}'\n")
    
    print("========================================")
    print("Uniendo todas las partes en 'video_final.mp4'...")
    print("========================================")
    
    concat_cmd = [
        "ffmpeg", "-y",
        "-f", "concat",
        "-safe", "0",
        "-i", list_file_path,
        "-c", "copy",
        final_output_path
    ]
    
    try:
        subprocess.run(concat_cmd, check=True)
        print(f"\n¡PROCESO COMPLETADO CON ÉXITO!")
        print(f"Video final guardado en: {final_output_path}")
        
        # Opcional: Limpiar archivos temporales individuales
        # for part in processed_parts:
        #     os.remove(part)
        # os.remove(list_file_path)
        
    except subprocess.CalledProcessError as e:
        print(f"[ERROR] Ocurrió un fallo al concatenar los videos: {e}")
else:
    print("No se generó ninguna parte válida para unir.")
