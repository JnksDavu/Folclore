extends CanvasModulate

const COR_NOITE = Color("#0a0e47")
const COR_DIA = Color("#c63ece")
const ESCALA_TEMPO = 0.2

var time = 0
var ciclo_ativo = true

func _process(delta: float) -> void:
	if ciclo_ativo:
		self.time += delta * ESCALA_TEMPO
	
		if self.time >= 1.5:
			self.time = 0.0
			self.color = COR_DIA
		else:
			self.color = COR_NOITE.linear_interpolate(COR_DIA, abs(sin(time)))

		if self.color == COR_DIA:
			ciclo_ativo = false