shader_type canvas_item;


uniform int iterations : hint_range(0, 100, 1) = 17;
uniform float formuparam : hint_range(0.0, 100.0, 0.001) = 0.53;


uniform int volsteps : hint_range(0, 100, 1) = 20;
uniform float stepsize : hint_range(0.0, 100.0, 0.001) = 0.1;


uniform float zoom : hint_range(0.0, 100.0, 0.001) = 0.800;
uniform float tile : hint_range(0.0, 100.0, 0.001) = 0.850;
uniform vec3 speed = vec3(0.0, 3, 1);


uniform float brightness : hint_range(0.0, 100.0, 0.0001) = 0.0015;
uniform float darkmatter : hint_range(0.0, 100.0, 0.001) = 0.300;
uniform float distfading : hint_range(0.0, 100.0, 0.001) = 0.730;
uniform float saturation : hint_range(0.0, 100.0, 0.001) = 0.850;
uniform vec4 colorize : source_color = vec4( 0.0, 0.0, 0.0, 1.0 );


uniform vec2 iMouse = vec2(0.0, 0.0);


void fragment()
{
	//get coords and direction
	vec2 uv=FRAGCOORD.xy/(1.0 / SCREEN_PIXEL_SIZE.xy)-.5;
	uv.y*=(1.0 / SCREEN_PIXEL_SIZE.xy).y/(1.0 / SCREEN_PIXEL_SIZE.xy).x;
	vec3 dir=vec3(uv*zoom,1.);
	vec3 time=vec3(speed * TIME * 0.001);//vec3(speed.x * TIME * 00.1, speed.y * TIME * 0.1, speed.z * TIME * 0.1);


	//mouse rotation
	float a1=.5+iMouse.x/(1.0 / SCREEN_PIXEL_SIZE.xy).x*2.;
	float a2=.8+iMouse.y/(1.0 / SCREEN_PIXEL_SIZE.xy).y*2.;
	mat2 rot1=mat2(vec2(cos(a1),sin(a1)),vec2(-sin(a1),cos(a1)));
	mat2 rot2=mat2(vec2(cos(a2),sin(a2)),vec2(-sin(a2),cos(a2)));
	dir.xz*=rot1;
	dir.xy*=rot2;
	vec3 from=vec3(1.,.5,0.5);
	from+=time;
	from.xz*=rot1;
	from.xy*=rot2;
	
	//volumetric rendering
	float s=0.1,fade=1.;
	vec3 v=vec3(0.);
	
	for (int r=0; r<volsteps; r++) {
		vec3 p=from+s*dir*.5;
		p = abs(vec3(tile)-mod(p,vec3(tile*2.))); // tiling fold
		float pa,a=pa=1.0;
		for (int i=0; i<iterations; i++) { 
			p=abs(p)/dot(p,p)-formuparam; // the magic formula
			a+=abs(length(p)-pa); // absolute sum of average change
			pa=length(p);
		}
		float dm=max(0.,darkmatter-a*a*.001); //dark matter
		a*=a*a; // add contrast
		if (r>6) fade*=1.-dm; // dark matter, don't render near
		//v+=vec3(dm,dm*.5,0.);
		v+=fade;
		v+=vec3(s,s*s,s*s*s*s)*a*brightness*fade; // coloring based on distance
		fade*=distfading; // distance fading
		s+=stepsize;
	}
	
	v=mix(vec3(length(v)), v / (1.0 - colorize.rgb),saturation); //color adjust
	COLOR = vec4(v*.01,1.);	
	
}