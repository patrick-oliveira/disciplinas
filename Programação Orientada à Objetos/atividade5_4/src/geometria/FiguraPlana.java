package geometria;

public abstract class FiguraPlana {
	public float area;
	public float perimetro;
	public float numero_lados;
	
	public float getArea() {
		return area;
	}
	public float getPerimetro() {
		return perimetro;
	}
	public float getNumeroLados() {
		return numero_lados;
	}
	public abstract void setArea();
	public abstract void setPerimetro();
	public abstract void setNumeroLados();
	
	public int comparaFigura(FiguraPlana fig2) {
		if(numero_lados > fig2.numero_lados) {
			return 1;
		} else if (fig2.numero_lados > numero_lados) {
			return -1;
		} else {
			if(area > fig2.area) {
				return 1;
			} else if (fig2.area >area) {
				return -1;
			} else {
				if(perimetro > fig2.perimetro) {
					return 1;
				} else if(fig2.perimetro > perimetro) {
					return -1;
				} else {
					return 0;
				}
			}
		}
	}
}
