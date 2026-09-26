Para probar el 3306 hacia DB-Server (debe decir ABIERTO)
bash

nc -w 3 10.6.97.18 3306 </dev/null >/dev/null 2>&1 && echo "✅ Puerto ABIERTO (esperado)" || echo "❌ Puerto CERRADO"
Para probar hacia Internet (debe decir CERRADO)
bash

nc -w 3 8.8.8.8 443 </dev/null >/dev/null 2>&1 && echo "⚠️ Puerto ABIERTO (NO esperado)" || echo "✅ Puerto CERRADO (esperado)"
Para probar hacia Usuarios (debe decir CERRADO)

nc -w 3 10.6.97.130 80 </dev/null >/dev/null 2>&1 && echo "⚠️ Puerto ABIERTO (NO esperado)" || echo "✅ Puerto CERRADO (esperado)"