import os
from PIL import Image

class ImageOptimizer:
    def __init__(self, input_folder='input', output_folder='output', max_width=1920):
        # Defino las rutas relativas. Si no existen, el script fallaría, así que las creo.
        self.input_folder = input_folder
        self.output_folder = output_folder
        self.max_width = max_width
        
        if not os.path.exists(self.output_folder):
            os.makedirs(self.output_folder)

    def optimize_image(self, filename):
        input_path = os.path.join(self.input_folder, filename)
        
        # Filtro para procesar solo archivos de imagen comunes
        valid_extensions = ('.jpg', '.jpeg', '.png')
        if not filename.lower().endswith(valid_extensions):
            return

        try:
            with Image.open(input_path) as img:
                # 1. Redimensionar si la imagen es gigantesca (preservando el ratio)
                if img.width > self.max_width:
                    ratio = self.max_width / float(img.width)
                    new_height = int((float(img.height) * float(ratio)))
                    img = img.resize((self.max_width, new_height), Image.Resampling.LANCZOS)
                
                # 2. Convertir y guardar como WebP
                # Le quito la extensión original (.jpg/.png) y le pongo .webp
                name_without_ext = os.path.splitext(filename)[0]
                output_path = os.path.join(self.output_folder, f"{name_without_ext}.webp")
                
                # Guardo con una calidad del 80% (el punto dulce entre peso y nitidez visual)
                img.save(output_path, 'webp', quality=80, optimize=True)
                
                # Calculo el ahorro de espacio para mostrarlo en consola
                original_size = os.path.getsize(input_path) / 1024
                new_size = os.path.getsize(output_path) / 1024
                
                print(f"✅ Optimizada: {filename}")
                print(f"   Peso reducido de {original_size:.1f}KB a {new_size:.1f}KB\n")

        except Exception as e:
            print(f"❌ Error al procesar {filename}: {e}")

    def run(self):
        print("Iniciando optimización masiva de imágenes...\n")
        
        if not os.path.exists(self.input_folder) or not os.listdir(self.input_folder):
            print(f"⚠️ La carpeta '{self.input_folder}' está vacía o no existe.")
            return

        # Itero sobre todos los archivos de la carpeta de entrada
        for filename in os.listdir(self.input_folder):
            self.optimize_image(filename)
            
        print("🚀 Proceso terminado. Revisa la carpeta 'output'.")

# Punto de entrada del script
if __name__ == "__main__":
    optimizer = ImageOptimizer()
    optimizer.run()