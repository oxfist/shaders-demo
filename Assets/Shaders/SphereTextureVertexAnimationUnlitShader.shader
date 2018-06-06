Shader "Unlit/Sphere Texture Vertex" {
	Properties {
		_MainTex("Texture", 2D) = "white" {}
		_Intensity("Animation Intensity", Float) = 0.15
		_AnimationSpeed("Animation Speed", Float) = 15
		_Tiling("Tiling Factor", Float) = 6
		_TextureSpeed("Texture Speed", Float) = 1.25
	}
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Tiling;
			float _AnimationSpeed;
			float _TextureSpeed;
			float _Intensity;
			
			v2f vert(appdata v) {
				v2f o;

				v.vertex.x -= (sin(_Time.x * _AnimationSpeed) + cos(_Time.x * _AnimationSpeed)) * _Intensity * v.vertex.x;
				v.vertex.y -= cos(v.vertex.x + v.vertex.y * _Time.y * _AnimationSpeed) * _Intensity * v.vertex.x;
				v.vertex.z += cos(v.vertex.y - v.vertex.z * _Time.y * _AnimationSpeed) * _Intensity * v.vertex.x;

				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target {
				fixed4 col = tex2D(_MainTex, _MainTex_ST.xy * i.uv * _Tiling + _TextureSpeed * _Time);
				return col;
			}
			ENDCG
		}
	}
}