# SAHAR VENEZUELA · Supabase + Vercel
1. Supabase: crea un proyecto > SQL Editor > pega y ejecuta schema.sql.
2. Authentication > Users > Add user (tu correo y contraseña). Copia su UUID y ejecuta la última línea de schema.sql (sin los guiones). En Authentication > Providers > Email desactiva "Allow new users to sign up".
3. Project Settings > API: copia Project URL y la clave anon/publishable en config.js.
4. Vercel: sube esta carpeta a un repositorio de GitHub > Vercel > Add New Project > importa el repo (Framework: Other, sin build). Deploy.
5. Entra en tu-dominio/#admin, inicia sesión, configura WhatsApp y crea tu primer perfume.
