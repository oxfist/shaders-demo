Shader "Unlit/Cube Vertex Animation" {
	Properties {
		_Speed("Speed", Float) = 500
		_Value1("Value 1", Float) = 0.05
	}

	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float _Speed;
			float _Value1;

			// vertex shader outputs
			struct v2f {
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
				fixed3 color : COLOR0;
			};

			// vertex shader
			v2f vert(appdata_base v) {
				v2f o;

				float xNormal = normalize(v.vertex.x);

				v.vertex.x += (sin(_Time.x * _Speed)) * _Value1 * xNormal;
				v.vertex.y += (cos(_Time.x * _Speed)) * _Value1 * xNormal;
				v.vertex.z += (sin(_Time.x * _Speed)) * _Value1 * xNormal;

				o.color = v.normal * 0.5 + 0.5;

				// transform position to clip space
				// (multiply with model * view * projection matrix)
				o.pos = UnityObjectToClipPos(v.vertex);

				return o;
			}

			// texture we will sample
			sampler2D _MainTex;
			
			// pixel shader; returns low precision ("fixed4" type)
			// color ("SV_Target" semantic)
			fixed4 frag(v2f i) : SV_Target {
				return fixed4(i.color, 1);
			}
			ENDCG
		}
	}
}