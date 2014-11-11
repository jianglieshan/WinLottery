#import "math.h"

/**
 * ±Ì¥≈º∆À„
 * @author wangst
 * @version 2014ƒÍ5‘¬24»’
 */
class MagnetUtil {
	/**
	 * ‘≤–Œ¥≈Ã˙±Ì¥≈º∆À„π´ Ωmm version
	 * ”¢¥Áº∆À„£∫1”¢¥Á=25.4mm
	 * @param Z(X) ¥≈∏–”¶æ‡¿Î (mm) ¥≈∏–”¶æ‡¿Î «¥≈Ã˙”Î±ª¥≈ªØµƒæ‡¿Î£¨±Ì¥≈ø…“‘…Ë÷√Œ™0
	 * @param D ¥≈Ã˙÷±æ∂ (mm)
	 * @param L ¥≈Ã˙≥§∂» (mm)
	 * @param Br  £¥≈Br(Gauss)magnet
	 * @return ∑µªÿ∏ﬂÀπ
	 */
	public: static double cylinder(double Z,double D,double L,double Br){
		double ret = 0;
		try {
			
			double zj = D / 2;
			double xzxs = 0;
			if(zj<=1.5){
				//xzxs = 0.59;
				xzxs = 0.55;
			}else if(zj>1.5 && zj<=2){
				//xzxs=0.62;
				xzxs = getY(1.5, 0.55, 2, 0.75, zj);
			}else if(zj>2 && zj<=3){
				//xzxs=0.75;
				xzxs = getY(2, 0.75, 3, 0.79, zj);
			}else if(zj>3 && zj<=4.5){
				//xzxs=0.79;
				xzxs = getY(3, 0.79, 4.5, 0.82, zj);
			}else if(zj>4.5 && zj<=5.5){
				//xzxs=0.82;
				xzxs = getY(4.5, 0.82, 5.5, 0.85, zj);
			}else if(zj > 5.5){
				xzxs=0.85;
				//xzxs = getY(5.5, 0.82, 18, 0.62, zj);
			}
			//LogUtil.showPrint("zj="+zj+" xzxs="+xzxs);
			double sc = Br;
			double bj = D / 2;
			double hd = L;
			double ccqd = xzxs*((sc/2)*hd)/sqrt((hd*hd)+(bj*bj));
			ret = ccqd;
			
			
		} catch (...) {
			// TODO: handle exception
			//e.printStackTrace();
		}
		return ret;
	}
	
	/**
	 * ∑Ω–Œ¥≈Ã˙¥≈¡¶º∆À„
	 * ”¢¥Áº∆À„£∫1”¢¥Á=25.4mm
	 * @param X ¥≈∏–”¶æ‡¿Î (mm)(¥≈∏–”¶æ‡¿Î£¨±Ì¥≈æ‡¿Î «0)
	 * @param width ¥≈Ã˙≥§∂»(mm)
	 * @param depth ¥≈Ã˙øÌ∂»(mm)
	 * @param height ¥≈Ã˙∏ﬂ∂» (mm) ≥‰¥≈∑ΩœÚ
	 * @param Brem  £¥≈Br (Gauss) magnet
	 * @return
	 */
	public: static double cuboid(double X, double width, double depth, double height, double Brem){
		double ret = 0;
		try {
			double pi =  M_PI;
			double W = width / 2;
			double De = depth / 2;
			//double Le = height;
			double B7 = De*De + W*W + X*X;
			double B8 = (X / (De*W)) * sqrt(B7);
			double B9 = atan(B8);
			double B10 = De*De + W*W + (X+height)*(X+height);
			double B11 = (X+height)/(De*W);
			double B12 = B11 * sqrt(B10);
			double B13 = atan(B12);
			double B14 = B13 - B9;
			ret = Brem * B14 / pi;
			
			double w = W;
			double h = De;
			double constW = 1;
			double constH = 1;
			
			/*if(w > 4){
				constW = 0.91;
			}else if(w>3 && w<=4){
				constW = 0.87;
			}else if(w>2.5 && w<=3){
				constW = 0.84;
			}else if(w>2 && w<=2.5){
				constW = 0.81;
			}else if(w>1.5 && w<=2){
				constW = 0.79;
			}else if(w>1 && w<=1.5){
				constW = 0.76;
			}else if(w>0.5 && w<=1){
				constW = 0.7;
			}else {
				constW = 0.58;
			}
			
			if(h > 4){
				constH = 0.91;
			}else if(h>3 && h<=4){
				constH = 0.87;
			}else if(h>2.5 && h<=3){
				constH = 0.84;
			}else if(h>2 && h<=2.5){
				constH = 0.81;
			}else if(h>1.5 && h<=2){
				constH = 0.79;
			}else if(h>1 && h<=1.5){
				constH = 0.75;
			}else if(h>0.5 && h<=1){
				constH = 0.7;
			}else {
				constH = 0.58;
			}*/
			
			//–¬µƒ∑Ω∑®
			if(w > 4){
				constW = 0.91;
			}else if(w>3 && w<=4){
				//constW = 0.87;
				constW = getY(3, 0.87, 4, 0.91, w);
			}else if(w>2.5 && w<=3){
				//constW = 0.84;
				constW = getY(2.5, 0.84, 3, 0.87, w);
			}else if(w>2 && w<=2.5){
				//constW = 0.81;
				constW = getY(2, 0.81, 2.5, 0.84, w);
			}else if(w>1.5 && w<=2){
				//constW = 0.79;
				constW = getY(1.5, 0.75, 2, 0.81, w);
			}else if(w>1 && w<=1.5){
				//constW = 0.75;
				constW = getY(1, 0.75, 1.5, 0.79, w);
			}else if(w>0.5 && w<=1){
				//constW = 0.7;
				constW = getY(0.5, 0.58, 1, 0.75, w);
			}else {
				constW = 0.58;
			}
			
			if(h > 4){
				constH = 0.91;
			}else if(h>3 && h<=4){
				//constH = 0.87;
				constH = getY(3, 0.87, 4, 0.91, h);
			}else if(h>2.5 && h<=3){
				//constH = 0.84;
				constH = getY(2.5, 0.84, 3, 0.87, h);
			}else if(h>2 && h<=2.5){
				//constH = 0.81;
				constH = getY(2, 0.81, 2.5, 0.84, h);
			}else if(h>1.5 && h<=2){
				//constH = 0.79;
				constH = getY(1.5, 0.79, 2, 0.81, h);
			}else if(h>1 && h<=1.5){
				//constH = 0.76;
				constH = getY(1, 0.76, 1.5, 0.79, h);
			}else if(h>0.5 && h<=1){
				//constH = 0.7;
				constH = getY(0.5, 0.58, 1, 0.76, h);
			}else {
				constH = 0.58;
			}
			
			ret = ret * constH * constW;
		} catch (...) {
			// TODO: handle exception
            //e.printStackTrace();
		}
		return ret;
	}
	
	/**
	 * ªÒ»°¡Ω∂Àµ„»∑∂®µƒ÷±œﬂ…œµƒµ„µƒY÷µ
	 * @param x1
	 * @param y1
	 * @param x2
	 * @param y2
	 * @param x
	 * @return
	 */
	public: static double getY(double x1,double y1,double x2,double y2,double x){
		double ret = 0;
		try {
			double k = (y1 - y2) / (x1 - x2);
			double b = y1 - k * x1;
			ret = k * x + b;
		} catch (...) {
			// TODO: handle exception
		}
		return ret;
	}
	
};
