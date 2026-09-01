precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;      
uniform sampler2D screen;   

void main() {
    vec4 windowColor = texture2D(tex, v_texcoord);
    vec4 backgroundColor = texture2D(screen, v_texcoord);

    float bgBrightness = dot(backgroundColor.rgb, vec3(0.299, 0.587, 0.114));
    vec3 tintColor = windowColor.rgb;

    vec3 finalGlass = tintColor * (bgBrightness * 1.5);

    gl_FragColor = vec4(mix(finalGlass, windowColor.rgb, 0.85), windowColor.a);
}
