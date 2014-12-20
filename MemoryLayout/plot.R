kernelMemoryPlot <- function(xValues) {
	lowerBound <- c(
	0xffffffffffe00000,
	0xffffffffff600000,
	0xffffffffa0000000,
	0xffffffff80000000,
	0xffffff8000000000,
	0xffffff0000000000,
	0xffffeb0000000000,
	0xffffea0000000000,
	0xffffe90000000000,
	0xffffc90000000000,
	0xffffc80000000000,
	0xffff8800ffffffff,
	0xffff800000000000,
	0x0000800000000000,
	0x0000000000000000)
	upperBound <- rep(0,length(lowerBounds))

	areaName <- c(
	"hole",
	"vsyscalls",
	"module mapping space",
	"kernel text mapping",
	"hole",
	"%esp fixup stack",
	"hole",
	"virtual memory map",
	"hole",
	"vmalloc/ioremap space",
	"hole",
	"phys. memory mapping",
	"hole",
	"sign extension hole",
	"userspace")
	
	areaColor <- c(
	"black",
	"green",
	"green",
	"green",
	"black",
	"green",
	"black",
	"green",
	"black",
	"green",
	"black",
	"green",
	"black",
	"black",
	"green")

	for(i in seq(2,length(lowerBound))) {
		upperBound[i] <- lowerBound[i-1]-1
	}

	upperBound[1] <- 0xffffffffffffffff

	jpeg("plot.jpg")
	plot(range(xValues),c(1,0),type="n")
	for(i in seq(1,length(lowerBounds))) {
		lines(c(lowerBound[i],upperBound[i]),c(i*0.1,i*0.1))

		xvalues <- c(lowerBound[i],upperBound[i],upperBound[i],lowerBound[i])
		yvalues <- c(0,0,1,1)

		polygon(xvalues,yvalues,density=-1,col=areaColor[i])
	}
	dev.off()
}


