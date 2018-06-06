Shader "Unlit/Sphere Vertex Animation" {
	Properties{
		_Intensity("Intensity", Float) = 0.15
		_Speed("Speed", Float) = 15
		_ColorFactor("Color Factor", Float) = 0.6
		_LightFactor("Light Factor", Float) = 0.45
	}

	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float _Intensity;
			float _Speed;
			float _ColorFactor;
			float _LightFactor;
			sampler2D _MainTex;

			// vertex shader outputs
			struct v2f {
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
				fixed3 color : COLOR0;
			};

			// vertex shader
			v2f vert(appdata_base v) {
				v2f o;

				v.vertex.x -= (sin(_Time.x * _Speed) + cos(_Time.x * _Speed)) * _Intensity * v.vertex.x;
				v.vertex.y -= cos(v.vertex.x + v.vertex.y * _Time.y * _Speed) * _Intensity * v.vertex.x;
				v.vertex.z += cos(v.vertex.y - v.vertex.z * _Time.y * _Speed) * _Intensity * v.vertex.x;

				o.color = tan(v.normal) * _ColorFactor + _LightFactor;

				o.pos = UnityObjectToClipPos(v.vertex);

				return o;
			}

			fixed4 frag(v2f i) : SV_Target {
				return fixed4(i.color, 1);
			}
			ENDCG
		}
	}
}