#ifndef CORE_INCLUDED
#define CORE_INCLUDED

float fPosterize(float input, float factor )
{
	return round(input/factor) * factor;
}

float fSaturate(float input)
{
	return clamp(input,0.,1.);
}

#endif