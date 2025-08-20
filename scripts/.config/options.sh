# Atualiza automaticamente as variáveis LINES e COLUMNS
# quando o terminal muda de tamanho (evita erros de layout em redimensionamento)
shopt -s checkwinsize

# Permite uso de ** em padrões globais para busca recursiva
# Exemplo: ls **/*.txt → lista todos os .txt recursivamente
shopt -s globstar
